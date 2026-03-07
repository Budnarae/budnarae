---
tags:
  - translation
  - imgui
---

---

## README.md

### The Pitch

Dear ImGui는 C++를 위한 **불필요한 부하 없는 그래픽 사용자 인터페이스 라이브러리(bloat‑free GUI library)**입니다. 최적화된 버텍스 버퍼(vertex buffers)를 생성하며, 이를 언제든지 3D 파이프라인을 사용하는 애플리케이션에서 렌더링할 수 있습니다. 빠르고, 이식 가능하며, 렌더러에 독립적이고, **외부 종속성이 없으며(self‑contained)** 자체적으로 완결됩니다.

Dear ImGui는 **빠른 반복 작업**과 **프로그래머를 위한 콘텐츠 제작 도구 또는 시각화/디버깅 도구를 만들 수 있게 하는 것(일반 최종 사용자용 UI가 아님)**을 목표로 설계되었습니다. 이 목표를 위해 단순성과 생산성을 중시하며, **일반적인 고수준 라이브러리에서 흔히 제공되는 일부 기능이 없을 수 있습니다.** 예: 완전한 국제화(오른쪽→왼쪽 텍스트, 양방향 텍스트, 텍스트 형태 조정 등) 및 접근성(accessibility) 기능은 지원되지 않습니다.

Dear ImGui는 특히 게임 엔진(툴링), 실시간 3D 애플리케이션, 풀스크린 애플리케이션, 임베디드 애플리케이션, 또는 운영체제 기능이 비표준인 콘솔 플랫폼에서 통합하기 적합합니다.

- 상태 동기화 최소화 (Minimize state synchronization)
    
- 사용자 쪽 UI 관련 상태 저장 최소화 (Minimize UI‑related state storage on user side)
    
- 설정 및 유지보수 최소화 (Minimize setup and maintenance)
    
- **동적 데이터세트를 반영하는 동적 UI를 쉽게 생성**할 수 있음 (Easy to use to create dynamic UI which are the reflection of a dynamic data set)
    
- **코드 기반 및 데이터 기반 도구 생성이 쉬움** (Easy to use to create code‑driven and data‑driven tools)
    
- **단기적 툴 또는 장기적 복잡한 툴 모두 쉽게 생성 가능** (Easy to use to create ad hoc short‑lived tools and long‑lived, more elaborate tools)
    
- **해킹하고 개선하기 쉬움** (Easy to hack and improve)
    
- 휴대성 높고 종속성 최소화, 콘솔 및 휴대폰 등 타깃 환경에서 실행 가능 (Portable, minimize dependencies, run on target (consoles, phones, etc.))
    
- **효율적인 런타임 및 메모리 소비** (Efficient runtime and memory consumption)
    
- 게임 업계의 주요 사용자들에게 **검증된 신뢰성** 보유 (Battle‑tested, used by many major actors in the game industry)
    

---

### Usage

Dear ImGui의 핵심은 몇 개의 플랫폼-독립 소스 파일로 구성되어 있으며, 손쉽게 애플리케이션/엔진에 컴파일해서 통합할 수 있습니다. 루트 폴더의 모든 파일(`imgui*.cpp`, `imgui*.h`)이 해당됩니다. 별도의 빌드 과정이 필요 없습니다. `.cpp` 파일을 기존 프로젝트에 추가하는 것만으로 통합 가능합니다.

`backends/` 폴더에는 다양한 그래픽 API 및 플랫폼 용 백엔드가, `examples/` 폴더에는 예제 애플리케이션이 제공됩니다. 혹은 직접 원하는 백엔드를 작성할 수도 있습니다. 텍스처 삼각형을 렌더링할 수 있는 곳이라면 어디서든 Dear ImGui를 렌더링할 수 있습니다.

보다 자세한 통합 방법은 "Getting Started & Integration" 섹션을 참고하세요.

Dear ImGui 설정 이후에는, **프로그래밍 루프 어디에서나** 다음과 같이 사용할 수 있습니다:

```cpp
ImGui::Text("Hello, world %d", 123);
if (ImGui::Button("Save"))
    MySaveFunction();
ImGui::InputText("string", buf, IM_ARRAYSIZE(buf));
ImGui::SliderFloat("float", &f, 0.0f, 1.0f);

// "My First Tool"이라는 윈도우 생성, 메뉴 바 포함
ImGui::Begin("My First Tool", &my_tool_active, ImGuiWindowFlags_MenuBar);
if (ImGui::BeginMenuBar())
{
    if (ImGui::BeginMenu("File"))
    {
        if (ImGui::MenuItem("Open..", "Ctrl+O")) { /* Do stuff */ }
        if (ImGui::MenuItem("Save",   "Ctrl+S"))   { /* Do stuff */ }
        if (ImGui::MenuItem("Close",  "Ctrl+W"))  { my_tool_active = false; }
        ImGui::EndMenu();
    }
    ImGui::EndMenuBar();
}

// 4개의 float로 저장된 색상 편집
ImGui::ColorEdit4("Color", my_color);

// 샘플을 생성하고 플롯
float samples[100];
for (int n = 0; n < 100; n++)
    samples[n] = sinf(n * 0.2f + ImGui::GetTime() * 1.5f);
ImGui::PlotLines("Samples", samples, 100);

// 스크롤 영역 안에 컨텐츠 표시
ImGui::TextColored(ImVec4(1,1,0,1), "Important Stuff");
ImGui::BeginChild("Scrolling");
for (int n = 0; n < 50; n++)
    ImGui::Text("%04d: Some text", n);
ImGui::EndChild();
ImGui::End();
```

Dear ImGui는 **간단한 단기 툴**부터 **복잡하고 장기적으로 운영되는 툴**까지 모두 생성하기에 적합합니다. 극단적인 경우인 **Edit&Continue (핫 코드 리로드)** 기능을 사용하면, 실행 중인 애플리케이션에 몇몇 위젯을 추가하여 변수 조정용 툴로 사용하다가 1분 뒤 코드를 제거할 수도 있습니다! Dear ImGui는 단순히 값을 조정하는 용도만이 아니라, 실행 중인 알고리즘을 추적하거나, 반사(reflection) 데이터를 사용하여 데이터세트를 실시간으로 탐색하거나, 엔진 내부를 노출하는 로거, 검토 도구, 프로파일러, 디버거, 게임 제작용 에디터/프레임워크 등을 만드는 용도로도 활용할 수 있습니다.

---

### How it works

IMGUI 패러다임은 API를 통해 **불필요한 상태 중복, 상태 동기화, 상태 유지**를 최소화하려고 합니다. 이는 **리테인 모드(retained‑mode) 인터페이스보다 오류 가능성이 적고 코드가 간결하며, 버그도 줄며, 동적 사용자 인터페이스 생성에 유리**합니다. 자세한 내용은 Wiki의 “About the IMGUI paradigm” 섹션을 참고하세요.

Dear ImGui는 버텍스 버퍼와 명령 호출 리스트(command lists)를 출력합니다. 이를 애플리케이션에서 쉽게 렌더링할 수 있고, 필요한 draw call 수나 상태 변경이 **상당히 적습니다**. Dear ImGui는 그래픽 상태를 직접 건드리지 않기 때문에, **알고리즘 실행 중이나, 혹은 자신의 렌더링 과정 중간 어디에서나 호출 가능**합니다. existing 코드베이스에 통합하는 방법은 `examples/` 폴더의 샘플 애플리케이션을 참조하세요.

흔한 오해 중 하나는 "이뮤디엇 모드 GUI(immediate mode GUI)는 드라이버/GPU를 무작정 호출해서 비효율적인 렌더링을 한다"는 것입니다. **Dear ImGui는 그런 방식이 아닙니다.** Dear ImGui는 버텍스 버퍼와 소량의 draw call 배치만을 출력하며, GPU를 직접 건드는 일은 없습니다. draw call 배치가 적절히 최적화되어 있으며, 애플리케이션 내부나 원격에서도 렌더링할 수 있습니다.

---

### Releases & Changelogs

자세한 변경 내역은 Releases 페이지에서 확인할 수 있습니다. 변경 로그(changelogs)를 읽으면 Dear ImGui의 최신 기능을 따라갈 수 있고, 놓친 기능에 대한 아이디어도 얻을 수 있습니다.

---

### Demo

`ImGui::ShowDemoWindow()` 함수를 호출하면 **다양한 기능과 예제를 보여주는 데모 윈도우**가 생성됩니다. 이 코드 전체는 항상 `imgui_demo.cpp`에서 참고할 수 있습니다. 다음은 데모가 어떻게 보이는지 예시입니다.

소스에서 예제(examples)를 빌드할 수 있어야 합니다. 안 되는 경우 알려주세요! Dear ImGui의 기능을 빠르게 확인했으면 한다면, Windows용 예제 바이너리도 다운로드할 수 있습니다:

- `imgui-demo-binaries-20241211.zip` (Windows, v1.91.6, 2024/11/11 빌드, master) 또는 이전 버전들.
    

데모 애플리케이션은 DPI 인식 기능이 없어서, 4K 화면에서는 흐릿하게 보일 수 있습니다. DPI 인식이 필요하면, 다른 크기로 폰트를 로드/리로드하거나, 스타일을 `style.ScaleAllSizes()`로 조정하세요 (FAQ 참조).

---

### Getting Started & Integration

자세한 내용은 Getting Started 가이드를 확인하세요.

대부분 플랫폼에서, C++ 환경이라면 `imgui_impl_xxxx` 백엔드를 **수정 없이(combination)** 사용할 수 있습니다 (예: `imgui_impl_win32.cpp` + `imgui_impl_dx11.cpp`). 엔진이 다중 플랫폼을 지원한다면, 직접 백엔드를 만들기보다는 `imgui_impl_xxxx` 파일들을 가능한 많이 포함하는 편이 작업량이 적고 Dear ImGui를 즉시 실행시킬 수 있어 유리합니다. 나중에 필요하다면 엔진 함수를 활용하는 커스텀 백엔드를 작성할 수도 있습니다.

Dear ImGui를 커스텀 엔진에 통합하는 작업은 다음과 같습니다:

1. 마우스/키보드/게임패드 입력 처리 전달
    
2. 폰트 아틀라스 텍스처를 GPU/렌더러에 업로드
    
3. 텍스처 바인딩 및 텍스처드 삼각형을 렌더링하는 렌더 함수 제공
    

backends/ 폴더에 예제도 있고, Getting Started 가이드를 따르면 **이론상 1시간 이내에 Dear ImGui 통합 가능**합니다. FAQ, 주석, 예제 코드들도 꼭 읽어보세요!

---

### Supported Backends & Bindings

**공식 제공 백엔드/바인딩 (저장소에 포함됨)**:

- 렌더러(Renderers): DirectX9, DirectX10, DirectX11, DirectX12, Metal, OpenGL / ES / ES2, SDL_GPU, SDL_Renderer2/3, Vulkan, WebGPU
    
- 플랫폼(Platforms): GLFW, SDL2/SDL3, Win32, Glut, OSX, Android
    
- 프레임워크(Frameworks): Allegro5, Emscripten
    

**타사(backends/bindings)는 위키 페이지**에서 확인 가능:

- 언어(Languages): C, C#, D, Go, JavaScript, Lua, Rust, ...
    
- 엔진/프레임워크(Frameworks): Unity, Unreal 등 다수
    

---

### Useful Extensions / Widgets

확장 위젯 예시들:

- 자동화/테스트(Automation/testing)
    
- 텍스트 에디터(Text editors)
    
- 노드 에디터(node editors)
    
- 타임라인 에디터(timeline editors)
    
- 플로팅/플롯(Plotting)
    
- 소프트웨어 렌더러(Software renderers)
    
- 원격 네트워크 접근(Remote network access)
    
- 메모리 에디터(Memory editors)
    
- 기즈모(Gizmos) 등 많습니다
    

특히 **ImPlot**과 **Dear ImGui Test Engine**은 잘 지원되고 있는 주목할 만한 확장입니다. Wiki의 해당 페이지도 참고하세요.

---

### Gallery

Dear ImGui를 사용한 예제 프로젝트들: Tracy(프로파일러), ImHex(헥스 에디터/데이터 분석), RemedyBG(디버거) 등 여러 사례가 있습니다. 사용자 제공 스크린샷은 Gallery 스레드를 참고하세요. 유용한 위젯 및 확장 목록은 Useful Extensions/Widgets 페이지에서 확인할 수 있습니다.

---

### Support, FAQ

- 일반 자주 묻는 질문은 FAQ( Frequently Asked Questions ) 페이지에서 확인할 수 있습니다.
    
- Getting Started 및 Wiki에는 많은 링크와 참고 자료가 포함되어 있습니다.
    
- IMGUI 패러다임에 대해 자세히 알고 싶다면 관련 아티클도 참고하세요.
    
- 자동화 및 테스트용 Dear ImGui Test Engine + Test Suite도 있습니다.
    
- GitHub Discussions는 **처음 사용하는 사용자**들이 컴파일/링크/실행이나 폰트 로딩 이슈가 있을 때 유용합니다. 그 외 버그, 요청, 피드백 등은 GitHub Issues에 올려주세요. New Issue 템플릿을 신중하게 작성해주세요.
    
- **기업 사용자 대상 개인 지원도 제공**됩니다. (이메일: `contact @ dearimgui dot com`)
    

---

### Which version should I get?

가끔 Release 태그(잘 정리된 릴리스 노트 포함)가 있지만, **대체로 `master` 또는 `docking` 브랜치 최신 버전을 사용하는 것이 안전하고 권장됩니다.** 라이브러리가 안정적이며, 문제가 보고되면 빠르게 수정됩니다.  
고급 사용자는 **Docking 및 Multi‑Viewport 기능을 포함한 `docking` 브랜치**를 활용할 수 있습니다. 이 브랜치는 정기적으로 master와 동기화됩니다.

---

### Who uses Dear ImGui?

Wiki의 Quotes, Funding & Sponsors, 그리고 “Software using Dear ImGui” 페이지를 보면 Dear ImGui를 사용하는 다양한 프로젝트와 사례를 확인할 수 있습니다. 사용중인 게임 또는 소프트웨어가 있다면 추가해 주세요! Gallery Threads도 참고할 수 있습니다.

---

### How to help

어떻게 도울 수 있나요?

- GitHub 포럼/이슈를 이용하세요.
    
- 개발에 기여하거나 PR을 제출할 수 있습니다. PR은 유지보수자에게 코드를 리뷰하도록 요청하는 것이며, 수락 시 해당 기능의 유지보수 책임도 일부 수반됩니다.
    
- Wiki의 Help wanted 페이지도 참고하세요.
    
- 후원자(Funding Supporter)가 될 수도 있습니다! 기업은 인보이스 통한 지원이나 Dear ImGui Test Engine 라이선스 구매 등을 통해 기여할 수 있습니다.
    

---

### Sponsors

Dear ImGui의 지속적인 개발은 사용자 및 후원자들의 재정 지원으로 이루어지고 있습니다. 현재 및 과거 후원자 목록은 위젯 페이지에서 확인할 수 있습니다. 2014년 11월부터 2019년 12월까지는 Patreon 및 개인 기부를 통한 재정 지원도 있었습니다.

이 프로젝트를 살아있게 하고 번창하게 해 준 모든 분께 감사드립니다!

Dear ImGui는 오픈 소스 프로젝트를 위한 **무료 소프트웨어 및 서비스를 사용하고 있습니다**:

- **PVS-Studio** (정적 분석: C/C++/C#/Java 지원)
    
- **GitHub Actions** (지속적 통합 CI)
    
- **OpenCppCoverage** (코드 커버리지 분석)
    

---

### Credits

Omar Cornut을 비롯한 **GitHub 기여자들**이 Dear ImGui 개발에 참여했습니다. 초기 버전은 Media Molecule의 지원을 받아 개발되었고 PS Vita 게임 _Tearaway_에서 내부적으로 처음 사용되었습니다.

**주기적 기여자**로는 Rokas Kupstys(@rokups, 2020–2022)가 있으며, 자동화 시스템 및 Dear ImGui Test Engine 레그레션 테스트 작업에 상당 부분 기여했습니다.

지원 계약, 후원 인보이스 및 기타 B2B 거래는 Disco Hello에서 호스팅 및 관리됩니다.

**Omar의 이야기:**

> “처음 IMGUI 패러다임을 발견한 것은 Q‑Games에서였고, Atman Binstock이 코드베이스에 구현한 간단한 버전을 개선하고 오랫동안 고심했습니다. 그는 Casey를 통해 이 개념을 직접 접했던 것 같습니다. Media Molecule로 옮긴 후 초기 구현의 결점을 넘어서는 새로운 라이브러리를 작성하기 위해 다시 작성했으며, 그것이 현재의 Dear ImGui가 되었습니다. 이후로도 상당한 시간이 지나도록 계속 iterations 및 개선을 반복하고 있습니다.”

**내장 리소스:**

- ProggyClean.ttf 폰트 (Tristan Grimmer, MIT 라이선스)
    
- stb_textedit.h, stb_truetype.h, stb_rect_pack.h (Sean Barrett, 퍼블릭 도메인)
    

**영감을 준 인물 및 테스트/피드백 참여자:**  
Casey Muratori, Atman Binstock, Mikko Mononen, Emmanuel Briney, Stefan Kamoda, Anton Mikhailov, Matt Willis 및 GitHub에서 피드백, 질문, 패치 등을 남겨 준 모든 분께 감사드립니다.

---

### License

Dear ImGui는 **MIT 라이선스** 하에 배포됩니다. 자세한 내용은 `LICENSE.txt`를 참고하세요.

