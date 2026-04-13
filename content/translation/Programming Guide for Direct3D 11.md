---
title: 'Programming Guide for Direct3D 11'
tags:
  - directX11
  - translation
---

# Devices

A Direct3D device allocates and destroys objects, renders primitives, and communicates with a graphics driver and the hardware.

Direct3D 장치는 객체를 할당하고 소멸시키며, 프리미티브(원시 도형, 간단한 이미지 등으로 번역될 수 있음)를 렌더하며, 그래픽스 드라이버 그리고 하드웨어와 통신한다.

In Direct3D 11, a device is separated into a device object for creating resources and a device-context object, which performs rendering.

DIrect3 11에서, 하나의 장치는 리소스를 생성하기 위한 `device` 객체와 렌더링을 위한 `device-context` 객체로 나뉜다.

This section describes Direct3D 11 device and device-context objects.

이번 단락에서는 Direct3D 11의 `device` 그리고 `device-context` 객체에 대해 서술한다.

Objects created from one device cannot be used directly with other devices.

하나의 장치에 의해 생성된 객체들은 다른 장치들에 의해 직접적으로 사용될 수 없다.

Use a shared resource to share data between multiple devices, with the constraint that a shared object can be used only by the device that created it.

공유 리소스를 사용하여 여러 장치 간에 데이터를 공유할 수 있으며, 공유 객체는 해당 객체를 만든 장치에서만 사용할 수 있다는 제약 조건이 있다.

# Indrocution to a Device in Direct3D 11

The Direct3D 11 object model separates resource creation and rendering functionality into a device and one or more contexts; this separation is designed to facilitate multithreading.

Direct3D 11의 객체 모델은 리소스 생성과 렌더링 기능을 `device`와 하나 또는 그 이상의 `contexts`로 분할한다; 이러한 분할은 멀티 스레딩을 용이하게 하기 위해 설계되었다.

## Device

A device is used to create resources and to enumerate the capabilities of a display adapter.

`device`는 리소스를 생성하고 디스플레이 어댑터의 기능을 열거하기 위해 사용된다.

In Direct3D 11, a device is represented with an [**ID3D11Device**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11device) interface.

Direct3D 11에서, `device`는 **ID3D11Device** 인터페이스에 의해 나타내진다.

Each application must have at least one device, most applications only create one device.

각 실행프로그램은 적어도 하나의 `device`를 보유해야 하며, 대부분의 실행프로그램은 딱 하나의 `device`만 생성한다.

Create a device for one of the hardware drivers installed on your machine by calling [**D3D11CreateDevice**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-d3d11createdevice) or [**D3D11CreateDeviceAndSwapChain**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-d3d11createdeviceandswapchain) and specify the driver type with the [**D3D_DRIVER_TYPE**](https://learn.microsoft.com/en-us/windows/desktop/api/D3DCommon/ne-d3dcommon-d3d_driver_type) flag.

당신의 기기 위에 설치된 하드웨어 드라이브 중 하나를 위한 `device`를 생성하기 위해 **D3D11CreateDevice** 또는 **D3D11CreateDeviceandSwapChain**을 호출한다.
**D3D_DRIVER_TYPE** 플래그로 드라이버의 타입을 특정한다.

Each device can use one or more device contexts, depending on the functionality desired.

각각의 `device`는  원하는 기능에 따라 하나 혹은 그 이상의 `device contexts`를 사용할 수 있다.

## Device Context

A device context contains the circumstance or setting in which a device is used.

`device context`는 장치가 사용되는 상황 또는 설정을 포함한다.

More specifically, a device context is used to set pipeline state and generate rendering commands using the resources owned by a device.

더 자세히 말하자면, `device context`는 파이프라인의 상태를 설정하거나, 디바이스가 보유한 리소스를 사용한 렌더링 명령어를 생성하는데 사용된다.

Direct3D 11 implements two types of device contexts, one for immediate rendering and the other for deferred rendering; both contexts are represented with an [**ID3D11DeviceContext**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11devicecontext) interface.

Direct3D 11은 두 종류의 `device context`를 가진다. 하나는 즉시 렌더링을 위한 것이고 하나는 지연 렌더링을 위한 것이다; 두 개의 `context` 모두 **ID3D11DeviceContext** 인터페이스를 사용하여 나타내진다.

### Immediate Context

An immediate context renders directly to the driver.

즉시 컨텍스트는 즉각적으로 드라이버에 렌더한다.

Each device has one and only one immediate context which can retrieve data from the GPU.

각 장치는 GPU로부터 자료를 받아들일 수 있는 즉시 컨텍스트를 '하나' 보유하고 있다.

An immediate context can be used to immediately render (or play back) a [command list](https://learn.microsoft.com/en-us/windows/win32/direct3d11/overviews-direct3d-11-render-multi-thread-command-list).

즉각적인 컨텍스트를 사용하여 명령 목록을 즉시 렌더링(또는 재생)할 수 있다.

There are two ways to get an immediate context:

즉시 컨텍스트를 가져올 수 있는 방법은 2가지가 있다.

- By calling either [**D3D11CreateDevice**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-d3d11createdevice) or [**D3D11CreateDeviceAndSwapChain**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-d3d11createdeviceandswapchain).
- By calling [**ID3D11Device::GetImmediateContext**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-id3d11device-getimmediatecontext).

- **D3D11CreateDevice**나 **D3D11CreateDeviceAndSwapChain**을 호출하는 것.
- **ID3D11Device::GetImmediateContext**를 호출하는 것.

### Deferred Context

A deferred context records GPU commands into a [command list](https://learn.microsoft.com/en-us/windows/win32/direct3d11/overviews-direct3d-11-render-multi-thread-command-list).

지연 컨텍스트는 GPU 명령어를 명령어 목록에 기록한다.

A deferred context is primarily used for multithreading and is not necessary for a single-threaded application.

지연 컨텍스트는 멀티 스레딩을 위해 주로 사용되며 싱글 스레드에서는 필수적이지 않다.

A deferred context is generally used by a worker thread instead of the main rendering thread.

지연 컨텍스트는 일반적으로 핵심 렌더링 스레드 대신 작업자 스레드에 의해 사용된다.

When you create a deferred context, it does not inherit any state from the immediate context.

지연 컨텍스트를 생성할 때, 즉시 컨텍스트의 어떠한 상태도 상속하지 않는다.

To get a deferred context, call [**ID3D11Device::CreateDeferredContext**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nf-d3d11-id3d11device-createdeferredcontext).

지연 컨텍스트를 가져오기 위해선, **ID3D11Device::CreateDeferredContext**를 호출한다.

Any context -- immediate or deferred -- can be used on any thread as long as the context is only used in one thread at a time.

즉시 그리고 지연 컨텍스트는 어떠한 스레드에 의해서도 사용될 수 있지만 하나의 스레드는 한 번에 하나의 컨테스트만 사용할 수 있다.

## Threading Considerations

This table highlights the differences in the threading model in Direct3D 11 from prior versions of Direct3D.

이 단락은 Direct3D 11의 스레딩 모델과 이전 버전 Direct3D의 스레딩 모델 간의 차이를 강조한다.

Differences between Direct3D 11 and previous versions of Direct3D:  
All [**ID3D11Device**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11device) interface methods are free-threaded, which means it is safe to have multiple threads call the functions at the same time. 

이전 버전의 Direct3D와 11 버전의 차이:
모든 **ID3D11Device** 인터페이스의 메소드들은 여러 스레드에 의해 동시에 호출되어도 안전하다(스레드에 대해 안전하다).

- All [**ID3D11DeviceChild**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11devicechild)-derived interfaces ([**ID3D11Buffer**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11buffer), [**ID3D11Query**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11query), etc.) are free-threaded.
- 모든 **ID3D11DeviceChild**를 상속하는 인터페이스들(**ID3D11Buffer**, **ID3D11Query**, 기타)는 스레드에 대해 안전하다.
- Direct3D 11 splits resource creating and rendering into two interfaces. Map, Unmap, Begin, End, and GetData are implemented on [**ID3D11DeviceContext**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11devicecontext) because [**ID3D11Device**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11device) strongly defines the order of operations. [**ID3D11Resource**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11resource) and [**ID3D11Asynchronous**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11asynchronous) interfaces also implement methods for free-threaded operations.
- Direct3D 11은 리소스 생성과 렌더링을 두 개의 인터페이스로 분할한다. `Map, Unmap, Begin, End, GetData`는 **ID3D11DeviceContext**에 구현되어 있다. 왜냐하면 **ID3D11Device**는 연산 순서를 강력하게 정의하기 때문이다. **ID3D11Resource**와 **ID3D11Asynchronous**는 메소드를 thread safe하게 구현한다.
- The [**ID3D11DeviceContext**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11devicecontext) methods (except for those that exist on [**ID3D11DeviceChild**](https://learn.microsoft.com/en-us/windows/desktop/api/D3D11/nn-d3d11-id3d11devicechild)) are not free-threaded, that is, they require single threading. Only one thread may safely be calling any of its methods (Draw, Copy, Map, etc.) at a time.
- **ID3D11DeviceContext** 메소드는 (**ID3D11DeviceChild**에 존재하는 것들을 제외하고) 스레드에 대해 안전하지 못하다. 따라서 단일 스레딩이 요구된다. 오직 한번에 하나의 스레드만이 이것의 메소드들(Draw, Copy, Map, 기타)을 안전하게 사용할 수 있다.
- In general, free-threading minimizes the number of synchronization primitives used as well as their duration. However, an application that uses synchronization held for a long time can directly impact how much concurrency an application can expect to achieve.
- 일반적으로 안전한 스레딩은 사용되는 동기화 프리미티브의 수와 그 기간을 최소화한다. 그러나 장시간 동기화를 사용하는 애플리케이션은 애플리케이션이 달성할 수 있는 동시성 수준에 직접적인 영향을 미칠 수 있다.

ID3D10Device interface methods are not designed to be free-threaded.

`ID3D10Device` 인터페이스 메소드들은 스레드에 대해 안전하지 않게 설계되었다.

ID3D10Device implements all create and rendering functionality as does ID3D9Device in Direct3D 9.

`ID3D10Device`는 Direct3D 9버전의 `ID3D9Device`와 마찬가지 방법으로 생성과 렌더링 기능을 구현한다.

Map and Unmap are implemented on ID3D10Resource-derived interfaces, Begin, End, and GetData are implemented on ID3D10Asynchronous-derived interfaces.

맵과 언맵은 ID3D10Resource 파생 인터페이스에서 구현되고, 시작, 종료, 데이터 가져오기는 ID3D10Asynchronous 파생 인터페이스에서 구현된다.

# Software Layers

The Direct3D 11 runtime is constructed with layers, starting with the basic functionality at the core and building optional and developer-assist functionality in outer layers.

Direct3D 11 실행시간은 여러 층으로 구성되어 있다. 중심부에는 근본적인 기능들이 있고 바깥쪽 층에는 선택적이며 개발자 의존적인 기능들이 있다.

This section describes the functionality of each layer.

이번 단원에서는 각 층의 기능들에 대해 서술한다.

As a general rule, layers add functionality, but do not modify existing behavior.

일반적인 규칙에 따라, 층들은 기능을 추가하지만, 기존에 존재하는 동작을 수정하진 않는다.

For example, core functions will have the same return values independent of the debug layer being instantiated, although additional debug output may be provided if the debug layer is instantiated.

예를 들어서, 핵심 함수들은 디버그 계층이 객체화되면 추가적인 디버그 출력을 가지는 데도 불구하고, 디버그 계층의 객체화 여부와는 독립적으로 같은 반환값을 가진다.

To create layers when a device is created, call D3D11CreateDevice or D3D11CreateDeviceAndSwapChain and supply one or more D3D11_CREATE_DEVICE_FLAG values.

장치를 생성할 때 층을 생성하려면 D3D11CreateDevice 또는 D3D11CreateDeviceAndSwapChain을 호출하고 하나 이상의 D3D11_CREATE_DEVICE_FLAG 값을 제공해야한다..

Direct3D 11 provides the following runtime layers:

Direct3D 11은 다음의 실행시간 층들을 제공한다.

## Core Layer

The core layer exists by default; providing a very thin mapping between the API and the device driver, minimizing overhead for high-frequency calls.

`core` 층은 기본적으로 존재한다; API와 장치 드라이버 사이에 아주 얇은 사상을 제공하며, 잦은 호출에 따른 오버헤드를 최소화한다.

As the core layer is essential for performance, it only performs critical validation.

`core` 층은 성능을 위해 필수적이며, 오직 중요 유효성 검사만 수행한다.

The remaining layers are optional.

나머지 층들은 선택적이다.

## Debug Layer

The debug layer provides extensive additional parameter and consistency validation (such as validating shader linkage and resource binding, validating parameter consistency, and reporting error descriptions).



To create a device that supports the debug layer, you must install the DirectX SDK (to get D3D11SDKLayers.dll), and then specify the D3D11_CREATE_DEVICE_DEBUG flag when calling the D3D11CreateDevice function or the D3D11CreateDeviceAndSwapChain function. If you run your application with the debug layer enabled, the application will be substantially slower. But, to ensure that your application is clean of errors and warnings before you ship it, use the debug layer. For more info, see Using the debug layer to debug apps.

 Note

For Windows 7 with Platform Update for Windows 7 (KB2670838) or Windows 8.x, to create a device that supports the debug layer, install the Windows Software Development Kit (SDK) for Windows 8.x to get D3D11_1SDKLayers.dll.

 Note

For Windows 10, to create a device that supports the debug layer, enable the "Graphics Tools" optional feature. Go to the Settings panel, under System, Apps & features, Manage optional Features, Add a feature, and then look for "Graphics Tools".

 Note

For info about how to debug DirectX apps remotely, see Debugging DirectX apps remotely.

 

Alternately, you can enable/disable the debug flag using the DirectX Control Panel included as part of the DirectX SDK.

When the debug layer lists memory leaks, it outputs a list of object interface pointers along with their friendly names. The default friendly name is "<unnamed>". You can set the friendly name by using the ID3D11DeviceChild::SetPrivateData method and the WKPDID_D3DDebugObjectName GUID that is in D3Dcommon.h. For example, to name pTexture with a SDKLayer name of mytexture.jpg, use the following code:


Copy
const char c_szName[] = "mytexture.jpg";
pTexture->SetPrivateData( WKPDID_D3DDebugObjectName, sizeof( c_szName ) - 1, c_szName );
Typically, you should compile these calls out of your production version.


