---
title: 'Imgui wiki Getting Started Win32 + DirectX11 번역본'
tags:
  - translation
---

_Win32 + DirectX11 환경의 번역만 구현되어 있음_

---

## Getting Started

**시작하기**  
_(Dear ImGui를 사용한 C++ 애플리케이션 통합 튜토리얼입니다. 이 페이지는 Dear ImGui API 사용법이 아니라 통합 방법에 대한 내용입니다. API 사용법은 이 페이지의 "Once you are setup…" 섹션을 참조해주세요.)_ ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

> 이 튜토리얼은 C++ 애플리케이션에 Dear ImGui를 통합하는 방법을 안내합니다.  
> Dear ImGui API를 사용하는 방법이 아니라, 준비가 완료된 이후의 부분(“Once you are setup…” 섹션)을 참고하십시오.  
> 또한 FAQ 및 기타 Wiki 페이지도 참조하세요.  
> 타 언어나 프레임워크에 대한 내용은 Bindings/Backends 페이지를 참고하십시오. ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

> 무엇보다 먼저, 예제 애플리케이션을 빌드하고 실행해보세요. Visual Studio에서는 `examples/imgui_examples.sln`을 열면 됩니다. Xcode 프로젝트나 Makefile도 제공됩니다.  
> 모든 SDK가 설치되어 있지 않더라도, 대부분의 경우 바로 실행 가능한 예제가 제공됩니다.  
> examples/ 폴더에는 다양한 윈도잉 및 그래픽 API를 사용하는 Dear ImGui 예제가 포함되어 있습니다. 이 예제들은 가능한 한 간단하게 만들어졌으며, 대부분의 예제 코드가 Dear ImGui 설정 자체보다도 윈도우 및 그래픽 API의 설정에 집중되어 있다는 점을 참고하세요.  
> Dear ImGui를 통합하는 데 문제가 있다면, 이런 예제를 참고하는 것이 가장 쉽고 빠른 해결 방법입니다.  
> 예제들은 매우 기초적 형태로 되어 있어, 멋진 폰트를 로드하지 않거나 Demo 창이 파일 시스템을 읽지 못하는 등의 제한이 있습니다. 예를 들어 텍스처 사용도 예제에서는 보여주지 않습니다. ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

---

## Game Loop?

**게임 루프?**  
_(Dear ImGui는 일반적으로 게임 개발 배경에서 사용됩니다. 대개 60 FPS 등 인터랙티브한 프레임 속도로 계속 업데이트되고, 그래픽 무거운 애플리케이션이 Dear ImGui 뒤에서 실행되어야 합니다. 이러한 전제들은 대부분 예제의 구조에 반영되어 있습니다. 일부 상황(예: idle 상태 또는 variable frame rate, “main viewport” 없음)에서도 사용 가능하지만, 기본적으로 잘 지원되지 않으며 심층적인 이해가 필요하므로 이 튜토리얼 범위를 벗어납니다.)_ ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

다음은 GPU 기반 렌더링 애플리케이션이 일반적으로 사용하는 루프의 예입니다:

```
while (application_not_closed)
{
   // Poll events
   // Update application/game state
   // Render contents into a framebuffer
   // Swap/Present framebuffer to the screen
   // Wait some time (e.g. 1/60 of a second)
}
```

예제에서는 swap/present 시 화면 새로고침과 동기화하도록 구성했습니다. 실제 애플리케이션에서는 프레임레이트를 조절하는 다양한 타이밍 메커니즘을 사용할 수 있지만, 이는 본 튜토리얼의 범위는 아닙니다. ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

---

## Compiling/Linking

**컴파일링/링킹** ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

1. 사용할 브랜치를 결정하세요:
    
    - `master` 또는 `docking` (Docking 및 Multi-viewports 지원 포함)
        
    - 두 브랜치 모두 유지되며 언제든지 전환 가능
        
2. 리포지토리를 프로젝트의 서브모듈로 추가하거나, 직접 복사하여 사용하세요.
    
3. 프로젝트나 빌드 시스템에 아래 파일들을 추가하여 컴파일 및 링크가 가능하게 설정하세요:
    
    - 루트 폴더의 모든 소스 파일: `imgui/{*.cpp,*.h}`
        
    - 사용하는 기술에 해당하는 `imgui/backends/imgui_impl_xxxx{.cpp,.h}` 파일을 추가 (예: SDL2 + DirectX11 사용 시 `imgui_impl_sdl2.cpp`, `imgui_impl_dx11.cpp` 등). 여러 API를 사용하는 엔진의 경우 여러 백엔드를 포함할 수 있음.
        
    - Visual Studio 사용자: 디버깅 경험 향상을 위해 `misc/debuggers/imgui.natvis` 및 `misc/debuggers/imgui.natstepfilter` 추가
        
    - `std::string` 사용자는 `misc/cpp/imgui_stdlib.*`를 추가하면 InputText에 쉽게 사용할 수 있음
        
4. `imgui/` 및 `imgui/backends/` 폴더를 include 경로에 추가하세요. (include 시 `backends/` 접두어를 사용하는 방법도 가능)
    

> 정적 또는 동적 라이브러리로 빌드하는 대신, 소스 파일을 직접 프로젝트에 포함하는 것이 추천됩니다. Dear ImGui는 작고 빌드하기 쉽기 때문에 파일을 직접 포함하는 것이 간단합니다. 또한, 함수 호출이 많은 API 특성상 shared 라이브러리로 만드는 것은 성능상 좋지 않을 수 있습니다.

> 링크 문제가 발생하는 대부분의 사용자들은 실제로 사용하는 윈도잉 또는 그래픽 기술과 관련된 설정 문제입니다. 예를 들어 DirectX11 사용 시 `d3d11.lib` 연결 필요, SDL2 사용 시 `SDL2.lib` 및 `SDL2main.lib` 필요 등입니다. 이미 애플리케이션이 정상작동 중이라면 header 및 라이브러리 설정은 제대로 되어 있을 가능성이 높습니다.

> 새로운 애플리케이션을 처음부터 만드는 경우, 다양한 윈도잉/그래픽 구조에 대해 Dear ImGui에서 자세히 문서화하지는 않았지만, examples/ 폴더에서 사용된 라이브러리 및 설정 예시를 참고할 수 있습니다. 일부 사람은 이 예제 자체를 복사해서 테스트용 애플리케이션을 시작하기도 합니다. 참고로 GLFW 3.2의 Windows용 precompiled 버전을 오랫동안 포함해왔습니다. ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

---

## Setting up Dear ImGui & Backends

**Dear ImGui 및 백엔드 설정** ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

1. 메인 라이브러리 헤더(`imgui.h`)와 백엔드 헤더(`imgui_impl_xxx.h`) 포함
    
2. `ImGui::CreateContext()`로 Dear ImGui 컨텍스트 생성
    
3. (선택적) 구성 플래그 설정, 폰트 로드, 스타일 설정
    
4. 플랫폼/렌더링 백엔드 초기화 (예: `ImGui_ImplWin32_Init()` + `ImGui_ImplDX11_Init()`)
    
5. 메인 루프 시작 부분: 이벤트 폴링 → `ImGui_ImplXXX_NewFrame()` 호출 → `ImGui::NewFrame()`
    
6. 메인 루프 끝 부분: `ImGui::Render()` → 렌더링 백엔드의 렌더 함수 호출 (예: `ImGui_ImplDX11_RenderDrawData()`)
    
7. 대부분의 백엔드는 이벤트 전달이나 후킹이 필요함 (예: `ImGui_ImplWin32_WndProcHandler`)
    
8. 백엔드 종료 함수 호출 및 `ImGui::DestroyContext()` 호출
    
9. 응용 프로그램 입력 로직에서 `ImGui::GetIO().WantCaptureMouse` / `WantCaptureKeyboard` 체크하여 Dear ImGui가 마우스/키보드 입력을 점유하고 있는지 확인하고, 필요 시 입력 전달을 중지 ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))
    

---

## Example: If you are using Raw Win32 API + DirectX11

**예시: Raw Win32 API + DirectX11 사용 시** ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

**Includes:**

```cpp
#include "imgui.h"
#include "imgui_impl_win32.h"
#include "imgui_impl_dx11.h"
```

**Initialization:**

```cpp
IMGUI_CHECKVERSION();
ImGui::CreateContext();
ImGuiIO& io = ImGui::GetIO();
io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;
io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;

ImGui_ImplWin32_Init(YOUR_HWND);
ImGui_ImplDX11_Init(YOUR_D3D_DEVICE, YOUR_D3D_DEVICE_CONTEXT);
```

**Main Loop Start:**

```cpp
ImGui_ImplDX11_NewFrame();
ImGui_ImplWin32_NewFrame();
ImGui::NewFrame();
ImGui::ShowDemoWindow();
```

**Main Loop End:**

```cpp
ImGui::Render();
ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
```

**WndProc Handler:**

```cpp
extern IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
if (ImGui_ImplWin32_WndProcHandler(hWnd, msg, wParam, lParam))
    return true;
```

**Shutdown:**

```cpp
ImGui_ImplDX11_Shutdown();
ImGui_ImplWin32_Shutdown();
ImGui::DestroyContext();
```

> That should be all! ([GitHub](https://github.com/ocornut/imgui/wiki/Getting-Started "Getting Started · ocornut/imgui Wiki · GitHub"))

