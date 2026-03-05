---
title: Sinhwa Hong's Portfolio
date: 2026-02-12
tags:
  - portfolio
---

# About Me

Hello, my name is Sinhwa Hong, and I am an aspiring Game Client/Engine Programmer.
I am currently seeking new opportunities in this field.

To build the necessary skills for my career goals, I completed both the Krafton GameTechLab and 42 Seoul programs.

At GameTechLab, I focused on game engine architecture and rendering systems.

In the first half of the program, I studied Unreal Engine's class hierarchy (`UObject`, `AActor`, `UPrimitiveComponent`, `FName`, etc.), naming conventions, and coding conventions, then implemented my own custom game engine based on DirectX 11.

In the second half, I collaborated with teammates using Perforce to develop an Unreal Engine 5 plugin that makes it easy to create aurora effects in a level, and we successfully published it on the FAB Marketplace.

At 42 Seoul, I completed several system programming projects using the POSIX API. By implementing projects such as a Ray Tracer, Unix Shell, and IRC Server in C/C++, I strengthened my foundation in low-level programming.

Both programs operate without traditional instructors and are based on self-directed learning, peer code reviews, and mentoring. Through this environment, I learned how to define and solve problems independently, which has enabled me to quickly adapt to new technologies and environments.

If you would like to know more about me, please feel free to reach out!

_Contact_  
Email: budnarae1001@gmail.com  
GitHub: https://github.com/budnarae  

# Skills

- **C / C++**
- **DirectX 11**
- **Unreal Engine 5 (Basic)**
- **POSIX-based Concurrent Programming**
- **Perforce, Git, RenderDoc (Basic), Docker**

# Projects

## Graphics & Engine

- **[[Volumetric Aurora]] | 09-2025 ~ 02-2026**  
  Developed a real-time aurora rendering plugin based on Unreal Engine 5 and published it on [Fab](https://www.fab.com/listings/57cba704-cfa8-4014-b6c2-b582822ce3fc).  
  Implemented using Ray Marching-based volume rendering techniques.

- **[[개요| Custom Game Engine (C++)]] | 09-2025 ~ 12-2025**  
  Implemented a custom game engine based on DirectX 11.  
  Developed Forward/Deferred rendering pipelines and post-processing systems.

- **miniRT | 06-2024 ~ 07-2024**  
  A Phong shading-based ray tracer.  
  Implemented ray–geometry primitive intersection tests and hard shadows.

- **FDF | 12-2023 ~ 01-2024**  
  A height map-based 3D wireframe renderer.  
  Implemented the Bresenham algorithm, matrix-based TRS transformations, and projection mode switching (Isometric/Cabinet).

## Systems Programming

- **IRC Server | 11-2024 ~ 12-2024**  
  Implemented a multi-client IRC server based on RFC 1459.  
  Designed non-blocking I/O using `select()` and implemented command handling, channel, and user management.

- **Philosophers | 02-2024 ~ 03-2024**  
  Implemented the Dining Philosophers problem with multithreading/process concurrency control.  
  Managed deadlock avoidance and data race handling using pthreads/mutexes and semaphores.

- **minishell | 01-2024 ~ 03-2024**  
  Implemented a Unix shell supporting pipelines and redirections.  
  Designed process control and IPC using `fork`, `pipe`, and `dup2`.
