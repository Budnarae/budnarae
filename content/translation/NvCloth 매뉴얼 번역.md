---
tags:
  - translation
  - graphics
---

_NvCloth_

---

# Compiling¶  

---

[원문](https://nvidiagameworks.github.io/NvCloth/1.1/Compiling/index.html)

---

CMake은(는) Android를 제외한 모든 플랫폼에서 NVIDIA의 packman 스크립트를 사용하여 자동으로 획득됩니다. 인터넷 연결이 필요합니다.

Windows¶  
Windows의 경우: 아래 의존성들을 다운로드하여 설치하세요:

- Visual Studio 12 이상(2013 이상)
    
- Windows 8.1 SDK [https://developer.microsoft.com/en-us/windows/downloads/windows-8-1-sdk](https://developer.microsoft.com/en-us/windows/downloads/windows-8-1-sdk)
    
- CUDA SDK [https://developer.nvidia.com/cuda-downloads](https://developer.nvidia.com/cuda-downloads) (버전 8 이상)
    

`scripts/locate_cuda.bat`을 편집하여 `bin`, `include`, `lib` 폴더를 포함하는 CUDA 설치 폴더를 가리키도록 설정하고, `scripts/locate_win8sdk.bat`을 편집하여 Windows SDK를 가리키도록 설정하세요(기본값: `C:\Program Files (x86)\Windows Kits\8.1`).

`CmakeGenerateAll.bat`를 실행하여 `compiler/vcXXwinXX-cmake/`에 Visual Studio 솔루션 파일들을 생성하세요. 예를 들어 Visual Studio 2015, 64-bit 대상 프로세서용 솔루션은 `compiler/vc14win64-cmake/` 폴더에 생성됩니다. 그런 다음 `NvCloth.sln`을 열고 Release/Debug 구성 중 하나를 선택하여 솔루션을 빌드하세요. 라이브러리 바이너리는 `compiler` 폴더 옆의 `bin` 폴더에 배치됩니다.

위의 프로젝트 생성 스크립트는 CUDA/DX11 솔버를 활성화할지 제어하는 선택적 명령행 인자를 제공합니다:

```
CmakeGenerateProjects.bat <0|1:use_cuda (default is 1)> <0|1:use_dx11 (default is 1)>
```

예:

```
CmakeGenerateProjects.bat 1 0
```

는 컴파일에 CUDA 솔버를 포함하지만 DX11 솔버는 제외합니다.

샘플의 Visual Studio 솔루션 파일을 생성하려면 `samples/CmakeGenerateProjects.bat`를 실행하세요 — 생성된 파일은 `samples/compiler/vc14winXX-cmake/CmakeGenerateProjects.bat`에 위치합니다. 샘플을 빌드하기 전에 assimp를 먼저 빌드해야 합니다. 예를 들어 `E:\nx0\sw\devrel\libdev\NvCloth\trunk\samples\external\assimp-4.1.0`을 실행한 뒤 `samples\external\assimp-4.1.0\compiler\vc14winXX-cmake\Assimp.sln`을 빌드하세요.

Linux¶  
`GenerateProjectsLinux.sh`를 실행하면 `compiler/linux64-XXXXX-cmake/`에 make 파일들이 생성됩니다.

CUDA 지원을 활성화/비활성화하려면 배포판에 포함된 `BuildProjectsLinux.sh` 스크립트에서 다음 줄을 변경하세요:

```
export USE_CUDA=0 # 0 for disable 1 for enable
```

`BuildProjectsLinux.sh` 스크립트를 실행하면 `compiler` 폴더에 다양한 makefile 기반 프로젝트가 생성됩니다. 필요한 디렉터리를 선택한 뒤 예를 들어 다음과 같이 빌드하세요:

```
cd compiler/linux64-release-cmake
```

그런 다음 (병렬 5개 프로세스로) 빌드 과정을 실행합니다:

```
make --jobs=5
```

라이브러리 바이너리는 `compiler` 폴더 옆의 `bin` 폴더에 배치됩니다.

참고: Linux 프로젝트 생성 스크립트 `GenerateProjectsLinux.sh`를 실행했을 때 다음과 같은 오류가 발생하면:

```
env: bash\r: No such file or directory
```

다음 명령으로 줄바꿈(라인엔딩)을 수정하면 됩니다:

```
sed $'s/\r$//' GenerateProjectsLinux.sh > GenerateProjectsLinux.sh.fixed && mv GenerateProjectsLinux.sh.fixed GenerateProjectsLinux.sh && chmod +x GenerateProjectsLinux.sh
```

또는 선호하는 텍스트 에디터를 사용하세요.

Mac¶  
`GenerateProjectsOsx.sh`를 실행하면 `compiler` 폴더에 Xcode 기반 프로젝트(32-bit 및 64-bit)가 생성됩니다. 필요한 프로젝트를 선택하세요. 예:

```
cd compiler/osx64-cmake
```

프로젝트를 Xcode에서 열어 IDE 내에서 빌드하거나, 대신 `BuildProjectsOsx.sh`를 사용하여 명령행에서 전체를 빌드할 수 있습니다.

라이브러리 바이너리는 `compiler` 폴더 옆의 `bin` 폴더에 배치됩니다.

참고: Mac 프로젝트 생성 스크립트 `GenerateProjectsOsx.sh`를 실행했을 때 다음과 같은 오류가 발생하면:

```
env: bash\r: No such file or directory
```

다음 명령으로 줄바꿈(라인엔딩)을 수정하세요:

```
sed $'s/\r$//' GenerateProjectsOsx.sh > GenerateProjectsOsx.sh.fixed && mv GenerateProjectsOsx.sh.fixed GenerateProjectsOsx.sh && chmod +x GenerateProjectsOsx.sh
```

iOS¶  
`GenerateProjectsIOS.sh`를 실행하면 `compiler/ios-cmake` 폴더에 Xcode 기반 프로젝트가 생성됩니다. 생성이 완료되면 Xcode에서 프로젝트를 열고 IDE 내에서 빌드하세요.

기본 iOS 배포 대상 버전은 8.0입니다(프로젝트 생성기 스크립트 내에서 변경할 수 있습니다).

또는 `BuildProjectsIOS.sh`를 사용하여 명령행에서 모든 것을 빌드할 수도 있습니다.

Android¶  
CMake 3.7을 [https://cmake.org/download/](https://cmake.org/download/) 에서 다운로드하여 설치하세요. `scripts/locate_cmake.bat`을 편집하여 CMake 실행 파일을 가리키도록 설정합니다.

NDK는 [https://developer.android.com/ndk/downloads/index.html](https://developer.android.com/ndk/downloads/index.html) 에서 다운로드하세요(테스트된 버전: r15c, r13b, r12b). `ANDROID_NDK_ROOT` 환경 변수를 NDK 루트 폴더를 가리키도록 설정하세요. 프로젝트 생성 스크립트를 실행합니다:

```
CmakeGenerateAndroid.bat release
```

CMake가 PATH에 있어야 합니다.

다음으로 `compiler\android-arm64-v8a-release-cmake` 폴더로 이동하여 다음을 실행하세요:

```
cmake --build .  -- -j5
```

라이브러리 바이너리는 `compiler` 폴더 옆의 `bin` 폴더에 배치됩니다.

참고: CMake를 사용해 Android 바이너리를 빌드하려면 NDK 내 특정 폴더가 필요한 바이너리를 가리키도록 되어 있어야 합니다. 구체적으로 다음의 심볼릭 링크(또는 복사/이름 변경)를 생성해야 할 수 있습니다:

```
<path_to_android_ndk>/toolchains/aarch64-linux-android-4.9/prebuilt/windows
```

를 다음으로:

```
<path_to_android_ndk>/toolchains/aarch64-linux-android-4.9/prebuilt/windows-x86_64
```

신규 NDK 버전에서는 이 작업이 필요하지 않을 수도 있으나 일부 버전에서는 필요할 수 있습니다.

---

# User Guide¶

이 섹션에서는 NvCloth를 설정하는 방법과 일반적인 기능들을 설명합니다.

---

## **Setup¶**

시뮬레이션을 시작하기 전에 약간의 설정이 필요합니다.  
여기서는 필요한 모든 구성 요소에 대한 개요를 제공하며,  
아래 섹션에서는 각 구성 요소에 대해 더 자세히 설명합니다.

- **NvCloth 라이브러리**  
    메모리 할당 등 콜백을 사용하므로 초기화가 필요합니다.
    
- **Factory**  
    다른 모든 오브젝트를 생성하는 인터페이스 객체.
    
- **Solver**  
    시뮬레이션과 타임 스텝을 관리합니다.
    
- **Fabric**  
    여러 인스턴스 간에 공유할 수 있는 옷감 정보(제약 길이, 연결 등)를 포함합니다.
    
- **Cloth**  
    의복 인스턴스 데이터(파티클 위치 등)를 포함합니다.
    

---

## **Initializing the Library¶**

NvCloth에서는 메모리 할당, 오류 보고, assert 처리, 프로파일 타이밍 등을  
사용자 정의 콜백으로 제공합니다.

이 콜백들은 라이브러리를 사용하기 전에  
`nv::cloth::InitializeNvCloth()`로 라이브러리에 전달해야 합니다.

콜백은 다음 인터페이스를 구현하는 클래스를 제공하여 구현합니다:

- `physx::PxAllocatorCallback`
    
- `physx::PxErrorCallback`
    
- `physx::PxAssertHandler`
    
- (선택) `physx::PxProfilerCallback`
    

`PxAllocatorCallback`이 반환하는 메모리는 **16바이트 정렬**이어야 합니다.

라이브러리는 별도의 deinit 과정이 필요 없습니다.

---

## **Factory¶**

Factory 객체는 시뮬레이션에 필요한 모든 구성 요소 생성 기능을 제공합니다.

플랫폼마다 다른 팩토리가 있으며(CPU, CUDA, DX11 등),  
다른 플랫폼에서 생성된 컴포넌트는 서로 호환되지 않습니다.  
(예: CPU cloth는 GPU solver에 추가할 수 없음)

팩토리는 다음과 같이 생성합니다:

```cpp
#include <NvCloth/Factory.h>

...

nv::cloth::Factory* factory = NvClothCreateFactoryCPU();
if(factory==nullptr)
{
       //error
}

...

//정리 시:
NvClothDestroyFactory(factory); //모든 플랫폼 팩토리에 공통
```

---

### **CUDA Factory 생성 예시**

```cpp
//// CUDA
#include <NvCloth/Factory.h>
#include <cuda.h>

...

CUcontext cudaContext;
int deviceCount = 0;
CUresult result = cuDeviceGetCount(&deviceCount);
ASSERT(CUDA_SUCCESS == result);
ASSERT(deviceCount >= 1);

result = cuCtxCreate(&cudaContext, 0, 0); //첫 번째 장치 사용
ASSERT(CUDA_SUCCESS == result);

nv::cloth::Factory* factory = NvClothCreateFactoryCUDA(cudaContext);
// factory 삭제 후 cuCtxDestroy(cudaContext) 호출 필요
```

---

### **DX11 Factory 생성 예시**

```cpp
//// DX11
#include <NvCloth/Factory.h>
#include <d3d11.h>

...

// DX11 컨텍스트 설정
ID3D11Device* DXDevice;
ID3D11DeviceContext* DXDeviceContext;
nv::cloth::DxContextManagerCallback* GraphicsContextManager;
D3D_FEATURE_LEVEL featureLevels[] = {D3D_FEATURE_LEVEL_11_0};
D3D_FEATURE_LEVEL featureLevelResult;
HRESULT result = D3D11CreateDevice(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, 0, featureLevels, 1, D3D11_SDK_VERSION, &DXDevice, &featureLevelResult, &DXDeviceContext);
ASSERT(result == S_OK);
ASSERT(featureLevelResult == D3D_FEATURE_LEVEL_11_0);
GraphicsContextManager = new DxContextManagerCallbackImpl(DXDevice);
ASSERT(GraphicsContextManager != nullptr);

nv::cloth::Factory* factory = NvClothCreateFactoryDX11(GraphicsContextManager);
// factory 삭제 후 DX 객체 모두 release 필요
```

---

## **Fabric & Cloth¶**

시뮬레이션 데이터는 두 개의 객체로 분리됩니다:

- **Fabric**
    여러 인스턴스에서 공유 가능한 데이터 (제약 길이, 연결 등)
    
- **Cloth**  
    인스턴스별 데이터 (파티클 위치 등)
    

여러 cloth 인스턴스가 하나의 fabric 데이터를 공유할 수 있습니다.

---

## **Fabric¶**

Fabric 생성이 초기 설정에서 가장 복잡한 부분입니다.

이를 단순화하기 위해 cooking extension을 제공합니다.  
mesh 데이터를 `nv::cloth::ClothMeshDesc`에 채워 넣은 뒤  
`NvClothCookFabricFromMesh`에 전달하여 fabric을 생성합니다.

```cpp
#include <NvClothExt/ClothFabricCooker.h>

...

nv::cloth::ClothMeshDesc meshDesc;

// meshDesc 데이터 채우기
meshDesc.setToDefault();
meshDesc.points.data = vertexArray;
meshDesc.points.stride = sizeof(vertexArray[0]);
meshDesc.points.count = vertexCount;
// quads, triangles, invMasses 등도 설정

physx::PxVec3 gravity(0.0f, -9.8f, 0.0f);
nv::cloth::Vector<int32_t>::Type phaseTypeInfo;
nv::cloth::Fabric* fabric = NvClothCookFabricFromMesh(factory, meshDesc, gravity, &phaseTypeInfo);

...

fabric->decRefCount();
```

- `phaseTypeInfo`는 이후 cloth phase 구성에 사용
    
- gravity는 수평/수직 제약을 구분하는데 사용됨
    
- fabric은 `decRefCount()`로 해제
    
- reference count가 0이 되면 자동 파괴
    
- 모든 fabric은 factory가 파괴되기 전에 destroy되어야 함  
    (따라서 fabric을 사용하는 cloth도 먼저 destroy되어야 함)
    

---

## **Cloth¶**

Fabric을 생성했다면 이제 cloth 인스턴스를 만들 수 있습니다.

초기 파티클 위치(=PxVec4 배열, w는 inverse mass)를 cloth 생성 시 제공해야 합니다:

```cpp
physx::PxVec4* particlePositions = ...; // w = inverse mass, 0이면 고정(정적)
nv::cloth::Cloth* cloth = factory->createCloth(
    nv::cloth::Range<physx::PxVec4>(particlePositions, particlePositions + particleCount),
    *fabric
);
// particlePositions는 여기서 free 가능
...

NV_CLOTH_DELETE(cloth);
```

---

### **Phase 설정**

Фabric에서 얻은 phaseTypeInfo를 기반으로 phase 별 속성을 설정합니다:

```cpp
nv::cloth::PhaseConfig* phases = new nv::cloth::PhaseConfig[fabric->getNumPhases()];
for(int i = 0; i < fabric->getNumPhases(); i++)
{
       phases[i].mPhaseIndex = i;

       switch(phaseTypeInfo[i])
       {
               case nv::cloth::ClothFabricPhaseType::eINVALID:
                       //ERROR
                       break;
               case nv::cloth::ClothFabricPhaseType::eVERTICAL:
                       break;
               case nv::cloth::ClothFabricPhaseType::eHORIZONTAL:
                       break;
               case nv::cloth::ClothFabricPhaseType::eBENDING:
                       break;
               case nv::cloth::ClothFabricPhaseType::eSHEARING:
                       break;
       }

       phases[i].mStiffness = 1.0f;
       phases[i].mStiffnessMultiplier = 1.0f;
       phases[i].mCompressionLimit = 1.0f;
       phases[i].mStretchLimit = 1.0f;
}
cloth->setPhaseConfig(nv::cloth::Range<nv::cloth::PhaseConfig>(phases, phases + fabric->getNumPhases()));
delete [] phases;
```

- gravity 값이 cook 시 mesh 공간과 일치해야 vertical phase가 정확하게 생성됨
    

---

## **Solver¶**

Solver는 cloth를 추가하고 시뮬레이션을 실행하는 “scene”과 같은 역할을 합니다.

```cpp
nv::cloth::Solver* solver = factory->createSolver();

...

NV_CLOTH_DELETE(solver);
```

### Cloth 추가/삭제:

```cpp
solver->addCloth(cloth);

...

solver->removeCloth(cloth);
```

### 시뮬레이션 수행:

```cpp
float deltaTime = 1.0f/60.0f;
solver->beginSimulation(deltaTime);
for(int i = 0; i < solver->getSimulationChunkCount(); i++)
{
       solver->simulateChunk(i);
}
solver->endSimulation();
```

- `simulateChunk()`는 여러 스레드에서 병렬로 호출 가능
    

---

## **Retrieving simulation data¶**

시뮬레이션 후 cloth 파티클 위치는 다음과 같이 얻을 수 있습니다:

```cpp
nv::cloth::MappedRange<physx::PxVec4> particles = mCloth->getCurrentParticles();
for(int i = 0; i<particles.size(); i++)
{
       // particles[i].xyz → 위치
       // particles[i].w   → invMass
}
// particles는 mCloth가 파괴되기 전에 해제되어야 함
```

---

## **Usage¶**

### **일반 Cloth 속성**

#### Gravity 설정

```cpp
cloth->setGravity(physx::PxVec3(0.0f, -9.8f, 0.0f));
```

cook 시 제공한 gravity와 달라도 됨.

---

#### Damping (감쇠)

```cpp
cloth->setDamping(0.5f); //기본값 = 0.0
```

- local space motion만 감쇠
    
- 공기 저항, 수중 효과는 wind/air drag 사용 권장
    

---

#### Solver Frequency

```cpp
cloth->setSolverFrequency(60.0f); //기본 = 300
```

- frame당 solver iteration 개수 조절
    
- 낮추면 안정성 증가, 높이면 강성 증가
    
- 보통 FPS의 배수로 설정함
    

---

## **Tethers (장력 보조 제약)**

Cooking 시 자동 생성되며, stretch 감소에 효과적.

### Scale:

```cpp
cloth->setTetherConstraintScale(1.2f); //20% 증가
```

### Stiffness:

```cpp
cloth->setTetherConstraintStiffness(0.0f); //비활성 (성능 ↑)
cloth->setTetherConstraintStiffness(0.5f); //스프링처럼
cloth->setTetherConstraintStiffness(1.0f); //기본값
```

---

## Collision detection (충돌 감지)

NvCloth는 시뮬레이션에 충돌을 추가하기 위해 몇 가지 다른 방식을 제공합니다.  
모든 충돌 프리미티브는 로컬 공간에서 정의됩니다.

---

우리는 각 cloth(천)에 대해 최대 32개의 충돌 구(sphere)를 정의할 수 있습니다:

```cpp
physx::PxVec4 spheres[2] = {
       // 각 벡터의 처음 3개 요소는 로컬 공간에서의 구의 중심이며, 4번째 요소는 반지름이다
       physx::PxVec4(0.0f, 0.0f, 0.0f, 1.0f),
       physx::PxVec4(0.0f, 5.0f, 0.0f, 1.0f)
};
nv::cloth::Range<const physx::PxVec4> sphereRange(spheres, spheres + 2);
cloth->setSpheres(sphereRange, 0, cloth->getNumSpheres());
```

마지막 두 인자는 이전에 정의된 구들 중 어떤 범위를 대체할지 정의합니다(이 매개변수는 모든 `Cloth::setCollisionShape` 함수에서 동일하게 동작).  
이것은 이전 프레임 이후 충돌 프리미티브 중 일부만 변경된 경우 유용합니다.

여기서는 `[0, cloth->getNumSpheres()[` 범위를 사용하여 이전에 정의되었을 수 있는 모든 구를 대체합니다.  
구를 처음에 삽입하려면 `[0, 0[`을, 마지막에 삽입하려면 `[cloth->getNumSpheres(), cloth->getNumSpheres()[` 를 사용할 수 있습니다.

---

구들을 연결하여 캡슐(capsule)을 만들 수 있습니다:

```cpp
uint32_t capsuleIndices[2];
capsuleIndices[0] = 0;
capsuleIndices[1] = 1;

cloth->setCapsules(nv::cloth::Range<uint32_t>(capsuleIndices, capsuleIndices + 2), 0, cloth->getNumCapsules());
```

위 코드는 sphere 0과 sphere 1을 연결합니다.  
인덱스는 항상 **짝수 개**(pair)로 제공해야 합니다.  
또한 마지막 두 인자는 쌍(pair)의 인덱스를 의미합니다.  
즉, 위 코드 실행 후 `cloth->getNumCapsules()` 는 **1**을 반환합니다.

---

우리는 최대 32개의 충돌 평면(plane)도 정의할 수 있습니다:

```cpp
physx::PxVec4 planes[2] = {
       physx::PxVec4(physx::PxVec3(0.5f, 0.4f, 0.0f).getNormalized(), 3.0f),
       physx::PxVec4(physx::PxVec3(0.0f, 0.4f, 0.5f).getNormalized(), 3.0f)
};

nv::cloth::Range<const physx::PxVec4> planesR(planes, planes + 2);
cloth->setPlanes(planesR, 0, cloth->getNumPlanes());
```

이것만으로는 cloth가 어떤 것과도 충돌하지 않습니다.  
우리는 먼저 solver에게 각 평면이 **하나의 convex shape**임을 알려야 합니다:

```cpp
uint32_t indices[2];
for(int i = 0; i < 2; i++)
       indices[i] = 1 << i;
nv::cloth::Range<uint32_t> indiceR(indices, indices + 2);
mCloth->setConvexes(indiceR, 0, mCloth->getNumConvexes());
```

`indices` 배열에 저장된 값은 어떤 평면이 convex shape에 포함되는지 알려주는 **비트 마스크**입니다.  
plane i 는 `1 << i` 비트로 표시됩니다.  
여러 평면을 포함하는 convex shape은 여러 비트를 OR 연산으로 조합하여 만들 수 있습니다.  
예: `(1<<i) | (1<<j)`.

---

임의의 삼각형(mesh) 충돌도 사용할 수 있습니다:

```cpp
physx::PxVec3* triangles = ...; //삼각형 데이터를 로드
                                //인덱스 메쉬/정점 공유 불가
                                //각 삼각형은 독립된 3개의 정점으로 정의해야 함
nv::cloth::Range<const physx::PxVec3> triangleR(triangles, triangles + triangleCount * 3);
cloth->setTriangles(triangleR, 0, cloth->getNumTriangles());
```

`setTriangles` 의 범위 인자는 **삼각형 개수 기준**임에 유의 (각 삼각형 = PxVec3 * 3).

---

충돌 시 마찰 계수는 다음과 같이 설정합니다:

```cpp
cloth->setFriction(0.5);
```

---

## **Local space simulation (로컬 공간 시뮬레이션)**

로컬 공간 시뮬레이션을 사용하면 시뮬레이션의 안정성과 반응성을 향상시키기 위한 더 많은 제어가 가능합니다.  
우리는 전역/렌더 좌표계를 입자 시뮬레이션 좌표계와 분리합니다.  
렌더링 시 cloth가 올바른 위치에 보이도록 그래픽 변환을 조정해야 합니다.

---

시뮬레이션에 cloth 좌표계가 전역 좌표계 대비 움직였음을 알려 주기 위해:

```cpp
cloth->setTranslation(physx::PxVec3(x,y,z));
cloth->setRotation(physx::PxQuat(qx,qy,qz,qw));
```

이것은 입자 위치를 직접 변경하지 않지만,  
cloth가 좌표계의 움직임에 제대로 반응하도록 **임펄스를 적용**합니다.  
공기 저항(drag)과 양력(lift)도 이에 따라 반응합니다.

---

빠른 움직임은 튜널링, 자기 충돌, 불안정성, 끌림 등 문제를 유발할 수 있습니다.  
이를 줄이기 위해 관성 계수(inertia multiplier)를 설정할 수 있습니다:

```cpp
//모든 값은 0.0 ~ 1.0
cloth->setLinearInertia(physx::PxVec3(x,y,z));
cloth->setAngularInertia(physx::PxVec3(ax,ay,az));
cloth->setCentrifugalInertia(physx::PxVec3(cx,cy,cz));
```

---

좌표계 이동 시 힘을 가하지 않고 cloth를 움직이고 싶으면(예: 월드 오리진 이동):

```cpp
cloth->teleport(physx::PxVec3(deltaX, deltaY, deltaZ));
```

또는 `setTranslation/setRotation` 사용 후 관성 효과를 지우기:

```cpp
cloth->clearInertia();
```

---

## **Drag, lift and wind (공기 저항, 양력, 바람)**

cloth는 기본적으로 진공 상태에서 시뮬레이션됩니다.  
보다 자연스러운 시뮬레이션을 위해:

```cpp
cloth->setDragCoefficient(0.5f);
cloth->setLiftCoefficient(0.6f);
```

바람 추가:

```cpp
cloth->setWindVelocity(physx::PxVec3(x,y,z));
```

시뮬레이션을 더 생생하게 하기 위해 값이 지속적으로 변하도록 하는 것이 좋습니다.

---

## **Distance/Motion constraints (거리/모션 제약)**

cloth 움직임을 일정 범위 안에 제한하여 안정성 또는 연출을 위해 사용할 수 있습니다.  
모션 제약은 각 입자의 움직임을 구 형태의 영역으로 제한합니다.

다음은 모션 제약 설정 예:

```cpp
nv::cloth::Range<physx::PxVec4> motionConstraints = cloth->getMotionConstraints();
for(int i = 0; i < (int)motionConstraints.size(); i++)
{
       motionConstraints[i] = physx::PxVec4(sphereCenter[i], sphereRadius[i]);
}
```

모든 모션 제약을 제거하려면:

```cpp
cloth->clearMotionConstraints();
```

반경은 다음과 같이 scale, bias로 변환할 수 있습니다:

```
newRadius = scale * oldRadius + bias  
(음수 방지 위해 clamp)
```

설정:

```cpp
cloth->setMotionConstraintScaleBias(scale, bias);
cloth->setMotionConstraintStiffness(stiffness);
```

---

## **Attaching cloth to animated characters (천을 애니메이션 캐릭터에 부착하기)**

천을 부착하는 방법은 두 가지:

1. **inverse mass = 0 인 잠긴 입자의 위치 갱신**
    
2. **모션 제약 사용**
    

두 방법을 동시에 사용하기도 함.

---

직접 입자 위치를 갱신하는 예시:

```cpp
{ // 이 범위가 끝나면 MappedRange 소멸자에서 업데이트가 트리거됨
       nv::cloth::MappedRange<physx::PxVec4> particles = cloth->getCurrentParticles();
       for all attached particles i
       {
       particles[attachmentVertices[i]] =
           physx::PxVec4(attachmentPositions[i], mAttachmentVertexOriginalPositions[i].w);
       }
}
```

- 잠기지 않은 입자의 위치도 변경할 수 있지만, 일반적으로 원치 않는 결과를 유발함
    
- w 성분을 바꾸어 질량을 동적으로 변경할 수도 있음
    
- 이를 통해 런타임에 입자를 잠그거나 잠금 해제할 수 있음
    

모션 제약도 유사하게 사용할 수 있으며, 반경 0의 구를 사용하면 입자를 고정할 수 있습니다.

또한 skinned mesh(캐릭터의 변형된 메쉬)에서의 거리 안에 cloth 입자가 머물도록 제한할 수도 있으며, 이는 안정성과 의도하지 않은 cloth 형태를 방지합니다.

점진적으로 제약 반경을 줄이는 방식으로  
**스킨된 클로스 ↔ 물리 클로스** 간의 블렌딩을 만들 수 있습니다.

---

## **Unit scaling (단위 스케일링)**

SI 단위를 사용하는 것이 물리적 의미를 가지는 값 사용에 좋지만,  
정밀도 문제나 게임 엔진과의 호환성 때문에 원하지 않을 수도 있습니다.

거리 단위를 n배 스케일링하는 규칙:

### 스케일링해야 하는 값(n배):

- 모든 선형 거리 값
    
- 정점 위치
    
- 압축/신장 한계
    
- 테더(tether) 및 rest 길이(보통 cooker가 처리함)
    
- 충돌 shape의 반지름
    
- 충돌 shape 위치
    
- 중력 (cooker의 중력은 방향만 중요)
    
- 바람 속도
    
- 충돌 거리
    

### **변하지 않아야 하는 값:**

- 강성(stiffness)
    
- 감쇠(damping)
    
- 강성 multiplier
    
- 테더 scale
    
- delta time
    
- 항력/양력 계수
    

### **유체 밀도(wind simulation)는 n⁻³ 배로 스케일해야 함**

예:  
데이터가 SI 단위(미터)인데 시뮬레이션을 센티미터 기준으로 하고 싶다면  
`n = 100`

---

## **Troubleshooting (문제 해결)**

### **cloth 일부가 사라짐(한 프레임 동안)**

cloth 일부 또는 전체가 사라질 수 있는데,  
이는 시뮬레이션에서 **float NaN**이 발생할 때 일어납니다.

일부 경우 다음 프레임에서 회복되지만,  
어떤 경우 cloth 일부 또는 전체가 영구적으로 사라질 수도 있습니다.

가장 일반적인 원인:

### **큰 constraint 오류(스트레칭 등)**

확인해야 할 사항:

- 빠르게 움직이는 collision shapes
    
- air drag/lift 또는 damping 적용된 상태에서의 빠른 충돌
    
- 큰 스트레칭 상태에서 air drag/lift 를 사용하면  
    삼각형 면적에 따라 매우 큰 힘이 발생할 수 있음
    
- damping은 cloth 속성에 덜 민감해서 덜 위험함
    

---

### **해결책:**

- solver 빈도 증가(프레임 레이트보다 높게)
    
    ```cpp
    cloth->setSolverFrequency(300);
    ```
    
    → 충돌 침투 감소, 천의 강성 증가에 도움
    
- 충돌 shape 침투 감소  
    (로컬 공간 시뮬레이션으로 전환)
    
- air drag/lift 감소 또는 비활성화
    

