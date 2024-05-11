#include <iostream>
#include <viennacl/vector.hpp>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include <cmath>
#include <chrono>

const int windowWidth = 800;
const int windowHeight = 600;
const int numPoints = 100; // Number of points in each vector

// Function to initialize the OpenGL context
void initOpenGL() {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f); // Set the background color
    glPointSize(5.0f); // Set the point size
}

// Function to render the points of the vectors
void renderPoints(GLFWwindow* window, const viennacl::vector<float>& v, const viennacl::vector<float>& w, float time) {
    // Clear the color buffer
    glClear(GL_COLOR_BUFFER_BIT);

    // Set the color of the points of the first vector to red
    glColor3f(1.0f, 0.0f, 0.0f);
    glBegin(GL_POINTS);
    for (int i = 0; i < numPoints; ++i) {
        glVertex2f(v[i], sin(v[i] * 10.0f + time) * 0.1f); // Alter the y coordinate of the points
    }
    glEnd();

    // Set the color of the points of the second vector to blue
    glColor3f(0.0f, 0.0f, 1.0f);
    glBegin(GL_POINTS);
    for (int i = 0; i < numPoints; ++i) {
        glVertex2f(w[i], cos(w[i] * 10.0f + time) * 0.1f); // Alter the y coordinate of the points
    }
    glEnd();

    // Connect the points of the vectors with lines
    glColor3f(1.0f, 1.0f, 1.0f);
    glBegin(GL_LINES);
    for (int i = 0; i < numPoints; ++i) {
        glVertex2f(v[i], sin(v[i] * 10.0f + time) * 0.1f);
        glVertex2f(w[i], cos(w[i] * 10.0f + time) * 0.1f);
    }
    glEnd();

    // Swap the buffers
    glfwSwapBuffers(window);
}

// Function to animate the points
void animatePoints(viennacl::vector<float>& v, viennacl::vector<float>& w, float time) {
    // Update the position of the points over time
    for (int i = 0; i < numPoints; ++i) {
        v[i] = static_cast<float>(i) / numPoints * 2.0f - 1.0f; // Distribute the points along the x-axis
        w[i] = static_cast<float>(i) / numPoints * 2.0f - 1.0f; // Distribute the points along the x-axis
    }
}

int main() {
    // GLFW initialization
    if (!glfwInit()) {
        std::cerr << "Error initializing GLFW" << std::endl;
        return -1;
    }

    // Create GLFW window
    GLFWwindow* window = glfwCreateWindow(windowWidth, windowHeight, "ViennaCL and GLFW", NULL, NULL);
    if (!window) {
        std::cerr << "Error creating GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }

    // Set the OpenGL context of the window
    glfwMakeContextCurrent(window);

    // ViennaCL initialization
    viennacl::vector<float> v(numPoints);
    viennacl::vector<float> w(numPoints);
    viennacl::vector<float> result(numPoints);

    // Initialize the OpenGL context
    initOpenGL();

    // Main loop
    auto startTime = std::chrono::high_resolution_clock::now();
    while (!glfwWindowShouldClose(window)) {
        // Calculate the time since the start of execution
        auto currentTime = std::chrono::high_resolution_clock::now();
        float time = std::chrono::duration_cast<std::chrono::duration<float>>(currentTime - startTime).count();

        // Animate the points
        animatePoints(v, w, time);

        // Render the points of the vectors
        renderPoints(window, v, w, time);

        // Check and handle events
        glfwPollEvents();
    }

    // Terminate GLFW
    glfwTerminate();

    return 0;
}
