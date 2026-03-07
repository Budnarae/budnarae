---
title: 'DirectX API'
tags:
  - directX11
  - translation
---

# ID3D11

## ID3D11Device

디바이스 인터페이스는 가상 어댑터를 나타냅니다. 리소스를 만드는 데 사용됩니다.

> 참고 
> 이 인터페이스의 최신 버전은 Windows 10 크리에이터스 업데이트 도입된 ID3D11Device5입니다. Windows 10 크리에이터스 업데이트 대상으로 하는 애플리케이션은 ID3D11Device 대신 ID3D11Device5 인터페이스를 사용해야 합니다.
 
### Inheritance

ID3D11Device 인터페이스는 IUnknown 인터페이스에서 상속됩니다. ID3D11Device 에는 다음과 같은 유형의 멤버도 있습니다.

### Method

#### ID3D11Device::CreateRenderTargetView

리소스 데이터에 액세스하기 위한 렌더링 대상 뷰를 만듭니다.

##### Syntax

```cpp

HRESULT CreateRenderTargetView(
  [in]            ID3D11Resource                      *pResource,
  [in, optional]  const D3D11_RENDER_TARGET_VIEW_DESC *pDesc,
  [out, optional] ID3D11RenderTargetView              **ppRTView
);

```

##### Parameter

`[in] pResource`

타입: `ID3D11Resource*`

렌더링 대상을 나타내는 ID3D11Resource 에 대한 포인터입니다. 이 리소스는 D3D11_BIND_RENDER_TARGET 플래그를 사용하여 만들어야 합니다.

`[in, optional] pDesc`

타입: `const D3D11_RENDER_TARGET_VIEW_DESC*`

렌더링 대상 뷰 설명을 나타내는 D3D11_RENDER_TARGET_VIEW_DESC 대한 포인터입니다. Mipmap 수준 0의 모든 하위 리소스에 액세스하는 뷰를 만들려면 이 매개 변수를 NULL 로 설정합니다.

`[out, optional] ppRTView`

타입: `ID3D11RenderTargetView**`

ID3D11RenderTargetView에 대한 포인터의 주소입니다. 이 매개 변수를 NULL 로 설정하여 다른 입력 매개 변수의 유효성을 검사합니다(다른 입력 매개 변수가 유효성 검사를 통과하면 메서드가 S_FALSE 반환).

##### Return

타입: HRESULT

이 메서드는 Direct3D 11 반환 코드 중 하나를 반환합니다.

##### Remarks

렌더링 대상 뷰는 ID3D11DeviceContext::OMSetRenderTargets를 호출하여 출력 병합기에 바인딩할 수 있습니다.

Windows 8 시작하는 Direct3D 11.1 런타임을 사용하면 다음과 같은 새로운 용도로 CreateRenderTargetView를 사용할 수 있습니다.

Direct3D 셰이더가 렌더링 대상 보기를 처리할 수 있도록 비디오 리소스의 렌더링 대상 보기를 만들 수 있습니다. 이러한 비디오 리소스는 Texture2D 또는 Texture2DArray입니다. 만든 렌더링 대상 보기에 대한 D3D11_RENDER_TARGET_VIEW_DESC 구조체의 ViewDimension 멤버 값은 Texture2D의 경우 D3D11_RTV_DIMENSION_TEXTURE2D, Texture2DArray의 경우 D3D11_RTV_DIMENSION_TEXTURE2DARRAY 비디오 리소스 형식과 일치해야 합니다. 또한 기본 비디오 리소스의 형식은 보기에서 사용할 수 있는 형식을 제한합니다. DXGI_FORMAT 참조 페이지의 비디오 리소스 형식 값은 보기가 제한된 형식 값을 지정합니다.

런타임 읽기+쓰기 충돌 방지 논리(리소스가 SRV 및 RTV 또는 UAV로 동시에 바인딩되지 않도록 하는)는 동일한 비디오 화면의 여러 부분 보기를 단순성을 위해 충돌하는 것으로 처리합니다. 따라서 하드웨어에서 이러한 동시 작업을 허용할 수 있더라도 애플리케이션이 동일한 표면의 크로마로 동시에 렌더링되는 동안 런타임에서는 애플리케이션이 루마(영상 밝기 정보)에서 읽을 수 없습니다.

---

## ID3D11DeviceContext

ID3D11DeviceContext 인터페이스는 렌더링 명령을 생성하는 디바이스 컨텍스트를 나타냅니다.

> 참고
> 이 인터페이스의 최신 버전은 Windows 10 크리에이터스 업데이트에 도입된 ID3D11DeviceContext4입니다. Windows 10 크리에이터스 업데이트를 대상으로 하는 애플리케이션은 ID3D11DeviceContext 대신 ID3D11DeviceContext4 인터페이스를 사용해야 합니다.
 
### Inheritance

ID3D11DeviceContext 인터페이스는 ID3D11DeviceChild에서 상속합니다. ID3D11DeviceContext는 ID3D11DeviceChild의 멤버 또한 보유합니다:

### Methods


---

# IDXGI

## IDXGISwapChain

IDXGISwapChain 인터페이스는 렌더링된 데이터를 출력에 표시하기 전에 저장하기 위해 하나 이상의 그래픽 표면(버퍼 등으로 의역하는 것이 자연스러울 듯)을 구현합니다.

### Inheritance

IDXGISwapChain 인터페이스는 IDXGIDeviceSubObject에서 상속합니다. IDXGISwapChain 또한 부모 객체의 멤버를 갖는다:

### Method

#### IDXGISwapChain::GetBuffer

스왑 체인의 백 퍼버들 중 하나에 접근한다.

##### Syntax

```cpp

HRESULT GetBuffer(
        UINT   Buffer,
  [in]  REFIID riid,
  [out] void   **ppSurface
);

```

##### Parameters

`Buffer`

타입 : UINT

0이 기본인 버퍼 인덱스입니다.

스왑 체인의 스왑 효과가 DXGI_SWAP_EFFECT_DISCARD인 경우 이 메서드는 첫 번째 버퍼에만 액세스할 수 있으므로 이 경우 인덱스를 0으로 설정합니다.

스왑 체인의 스왑 효과가 DXGI_SWAP_EFFECT_SEQUENTIAL 또는 DXGI_SWAP_EFFECT_FLIP_SEQUENTIAL인 경우, 스왑 체인의 0 인덱스 버퍼만 읽고 쓸 수 있습니다. 인덱스가 0보다 큰 스왑 체인의 버퍼는 읽기만 가능하므로, 이러한 버퍼에 대해 IDXGIResource::GetUsage 메서드를 호출하면 DXGI_USAGE_READ_ONLY 플래그가 설정되어 있습니다.

[in] riid

유형: REFIID

버퍼를 조작하는 데 사용되는 인터페이스 유형입니다.

[out] ppSurface

유형: void**

백 버퍼 인터페이스에 대한 포인터입니다.

##### Return value

타입: HRESULT

DXGI_ERROR 중 하나를 반환합니다.

