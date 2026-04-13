---
title: 'DirectX SDK Document - Tutorial 1 Direct3D 11 Basics'
tags:
  - directX11
  - translation
---
---

# Summary

In this first tutorial, we will go through the elements necessary to create a minimal Direct3D 11 application.

이 튜토리얼에서 우리는 최소한의 Direct3D 11 응용프로그램을 만들기 위해 필수적인 요소를 살펴볼 것이다.

Every Direct3D 11 application must have these elements to function properly.

모든 Direct3D 11 응용프로그램은 제대로 기능하기 위해서 이 요소들이 필요하다.

The elements include setting up a window and a device object, and then displaying a color on the window.

요소는 창이나 장치 객체를 설정하거나, 창에 색깔을 표시하는 것을 포함한다.

==Source==

`(SDK root)\Samples\C++\Direct3D11\Tutorials\Tutorial01`

## Setting up The Direct3D 11 Device

The first steps of creating the window and message loop are identical in Direct3D 9, Direct3D 10, and DIrectD3 11.

창과 메시지 루프를 만드는 첫번째 단계는 Direct3D 9, 10, 11에서 모두 동일하다.

See Direct3D 10 Tutorial 00: Win32 Basics for an introduction to this process.

이 단계에 대해 소개한 [[DirectX SDK Document - Tutorial 0 Win32 Basics]]을 보도록 하자.

Now that we have a window that is displaying, we can continue to set up a Direct3D 11 device.

이제 우리는 창을 얻었으므로, 계속해서 Direct3D 11 장치를 설정해보자.

SetUp is necessary if we are going to render any 3D scene.

3차원 장면을 렌더링하는데 설정은 필수적이다.

The first thing to do is to create three objects: a device, an immediate context, and a swap chain.

첫번째로 해야할 일은 3개의 객체를 만드는 것이다: 장치, 즉시 컨텍스트, 스왑 체인.

The immediate context is a new object in Direct3D 11.

즉시 컨텍스트는 Direct3D 11의 새로운 객체이다.

---

In Direct3D 10, the device object was used to perform both rendering and resource creation.

DIrect3D 10에서, 장치 객체는 렌더링과 리소스 생성을 둘 다 수행했다.

In Direct3D 11, the immeidate context is used by the application to perform rendering onto a buffer, and the device contains methods to create resources.

Direct3D 11에서 즉시 컨텍스트는 응용프로그램이 버퍼에 렌더링할 때 사용하고, 장치는 리소스를 생성하는 메서드를 포함한다.

---

The swap chain is responsible for taking the buffer to which the device renders, and displaying the content, on the actual monitor screen.

스왑 체인은 장치가 렌더링하는 버퍼를 저장하며, 버퍼의 내용을 실제 모니터 화면에 내용을 보여주는 역할을 한다.

The swap chain contians two or more buffers, mainly the front and the back.

스왑 체인은 두 개 이상의 버퍼를 포함하는데, 주로 프론트 버퍼와 백 버퍼이다.

These are textures to which the device renders in order to display on the monitor.

이들은 장치가 모니터에 표시하기 위해 렌더링할 텍스처들이다.

The front buffer is what is being presented currently to the user.

프론트 버퍼는 현재 사용자에게 보여지고 있는 버퍼이다.

This buffer is read-only and cannot be modified.

이 버퍼는 읽기 전용이며 수정이 불가능하다.

The back buffer is the render target to which the device will draw.

백 버퍼는 장치가 그리기를 수행할 렌더 타켓이다.

Once it finishes the drawing operation, the swap chain will present the backbuffer by swapping the two buffers.

한번 그리기를 수행하면, 장치는 백 버퍼를 표시하기 위해 두 개의 버퍼를 뒤바꾼다.

The back buffer becomes the front buffer, and vice versa.

백 버퍼는 프론트 버퍼가 되고, 프론트 버퍼는 백 버퍼가 된다.

---

To create the swap chain, we fill out a DXGI_SWAPCHAIN_DESC structure that describes the swap chain we are about to create.

스왑 체인을 만들기 위해, 우리가 만들 스왑 체인을 나타내는 DXGI_SWAPCHAIN_DESC 구조체를 작성한다.

A few fields are worth mentioning.

몇몇 필드는 언급할 가치가 있다.

**BackBufferUsage** is a flag that tells the application how the back buffer will be used.

**BackBufferUsage**는 응용프로그램에게 백버퍼가 어떻게 사용될지 알려주는 플래그이다.

In this case, we want to render to the back buffer, so we'll set **BackBufferUsage** to DXGI_USAGE_RENDER_TARGET_OUTPUT.

이 튜토리얼에서 우리는 백 버퍼에 렌더링하기를 원하므로 **BackBufferUsage**를 DXGI_USAGE_RENDER_TARGET_OUTPUT로 설정할 것이다.

The **OutputWindow** field represents the window that the swap chain will use to present images on the screen.

**OutputWindow** 필드는 스왑 체인이 화면에 이미지를 표시하기 위한 창을 나타낸다.

SampleDesc is used to enable multi-sampling.

SampleDesc는 멀티 샘플링을 가능하게 하기 위해 사용된다.

Since this tutorial does not use multi-sampling, SampleDesc's Count is set to 1 and Quality to 0 to have multi-sampling disabled.

이 튜토리얼은 멀티샘플링을 사용하지 않으므로, SampleDesc의 Count는 1로, Quality는 0으로 설정해서 멀티샘플링을 비활성화한다.

---

Once the description has been filled out, we can call the D3D11CreateDeviceAndSwapChain function to create both the device and the swap chain for us.

작성이 끝나면, 우리는 D3D11CreateDeviceAndSwapChain 함수를 호출하여 장치와 스왑 체인을
생성할 수 있다.

```cpp

DXGI_SWAP_CHAIN_DESC sd;
ZeroMemory( &sd, sizeof(sd) );
sd.BufferCount = 1;
sd.BufferDesc.Width = 640;
sd.BufferDesc.Height = 480;
sd.BufferDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
sd.BufferDesc.RefreshRate.Numerator = 60;
sd.BufferDesc.RefreshRate.Denominator = 1;
sd.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
sd.OutputWindow = g_hWnd;
sd.SampleDesc.Count = 1;
sd.SampleDesc.Quality = 0;
sd.Windowed = TRUE;

if( FAILED( D3D11CreateDeviceAndSwapChain( NULL, D3D_DRIVER_TYPE_HARDWARE, NULL, 0, featureLevels, numFeatureLevels, D3D11_SDK_VERSION, &sd, &g_pSwapChain, &g_pd3dDevice, NULL, &g_pImmediateContext ) ) )
{
	return FALSE;
}

```

---

The next thing we need to do is to create a render view.

다음으로 할 일은 렌더 뷰를 만드는 것이다.

A render target view is a type of resource view in Direct3D 11.

Direct3D 11에서 렌더 타겟 뷰는 리소스 뷰의 한 종류이다.

A resource view allows a resource to be bound to the graphics pipeline at a specific stage.

리소스 뷰는 리소스를 그래픽 파이프라인의 특정 단계에 바인딩할 수 있도록 해준다.

Think of resource views as typecast in C.

리소스 뷰를 C의 타입캐스트로 생각해보자.

A chunk of raw memory in C can be cast to any data type.

C에서 원시 메모리 덩어리는 어떠한 타입으로든 캐스트 될 수 있다.

We can cast that chunk of memory to an array of integers, an array of floats, a structure, an array of structures, and so on.

우리는 메모리 덩어리를 정수 배열, 실수 배열, 구조체, 구조체 배열, 그 외 등등으로 캐스트할 수 있다.

The raw memory itself is not very useful to us if we don't know its type.

원시 메모리 그 자체는 타입을 알 수 없다면 그닥 쓸모있지 않다.

Direct3D 11 resource views act in a similar way.

Direct3D 11의 리소스도 비슷한 원리로 기능한다.

For instance, a 2D texture, analogous to the raw memory chunk, is the raw underlying resource.

예를 들어, 2D texture는 원시 메모리 덩어리에 비유할 수 있다. 원시 저수준 리소스이다.

Once we have that resource we can create different resource views to bind that texture to different stages in the graphics pipeline with different formats: as a render target to which to render, as a depth stencil buffer that will receive depth information, or as a texture resource.

리소스가 확보되면 다양한 리소스 뷰를 생성하여 해당 텍스처를 렌더링할 렌더 대상, 깊이 정보를 수신할 깊이 스텐실 버퍼 또는 텍스처 리소스 등 다양한 포맷으로 그래픽 파이프라인의 여러 단계에 바인딩할 수 있다.

Where C typecasts allow a memory chunk to be used in a different manner, so do Direct3D 11 resource views.

C 타입캐스트가 메모리 청크를 다른 방식으로 사용할 수 있도록 허용하는 것처럼, Direct3D 11 리소스 뷰도 마찬가지이다.

---

We need to create a render target view because we would like to bind the back buffer of our swap chain as a render target.

우리는 스왑체인의 백 버퍼를 렌더 타깃으로서 바인드할 것이기 때문에 렌더 타깃을 만들어야 한다.

This enables Direct3D 11 to render onto it.

이를 통해 Direct3D 11은 렌더 타깃 위에 렌더링할 수 있다.

We first call **GetBuffer()** to get the back buffer object.

우리는 백 버퍼 객체를 가져오기 위해 처음에 **GetBuffer()**를 호출한다.

Optionally, we can fill in a D3D11_RENDERTARGETVIEW_DESC structure that describes the render target view to be created.

선택적으로, 생성할 렌더 타겟 뷰를 정의하는 D3D11_RENDERTARGETVIEW_DESC 구조체를 작성할 수 있다. 

This description is normally the second parameter to **CreateRenderTargetView**.

**CreateRenderTargetView**의 두번째 파라미터를 통해 정의된다.

However, for these tutorials, the default render target view will suffice.

하지만, 이 튜토리얼을 위해서는 기본 렌더 타깃 뷰로 족하다.

The default render target view can be obtained by passing NULL as the second parameter.

기본 렌더 타깃 뷰는 두번째 파라미터에 NULL을 전달함으로서 얻을 수 있다.

Once we have created the render target view, we can call **OMSetRenderTargets()** on the immediate context to bind it to the pipeline.

랜더 타깃 뷰를 생성하면, 우리는 즉시 컨텍스트에서 **OMSetRenderTargets()**를 호출하여 파이프라인에 바인드할 수 있다.

This ensures the output that the pipeline renders gets written to the back buffer.

이를 통해 파이프라인이 렌더링한 결과물이 백 버퍼에 작성됨을 보장할 수 있다.

The code to create and set the render target view is as follows:

렌더 타깃을 생성하고 설정하는 코드는 다음과 같다:

```cpp

// Create a render target view
ID3D11Texture2D *pBackBuffer;
if( FAILED( g_pSwapChain->GetBuffer( 0, __uuidof( ID3D11Texture2D ), (LPVOID*)&pBackBuffer ) ) )
	return FALSE;
hr = g_pd3dDevice->CreateRenderTargetView( pBackBuffer, NULL, &g_pRenderTargetView );
pBackBuffer->Release();
if( FAILED( hr ) )
	return FALSE;
g_pImmediateContext->OMSetRenderTargets( 1, &g_pRenderTargetView, NULL );

```

---

The last thing we need to set up before Direct3D 11 can render is initialize the viewport.

Direct3D 11로 렌더하기 위해 마지막으로 설정할 것은 뷰포트를 초기화하는 것이다.

The viewport maps clip space coordinates, where X and Y range from -1 to 1 and Z ranges from 0 to 1, to render target space, sometimes known as pixel space.

뷰포트는 목표 공간을 렌더하기 위한, x y 범위는 \[-1, 1]이며 z 범위는 \[0, 1]인 클립 좌표계(때때로 픽셀 좌표계로 불리기도 한다)를 사상한다.

In Direct3D 9, if the application does not set up a viewport, a default viewport is set up to be the same size as the render target.

Direct3D 9에서, 만약 응용프로그램이 뷰포트를 설정하지 않으면, 기본 뷰포트는 렌더 목표와 똑같은 크기로 설정된다.

In Direct3D 11, no viewport is set by default.

DIrect3D 11에서, 뷰포트는 기본적으로 설정되어있지 않다.

Therefore, we must do so before we can see anything on the screen.

그러므로, 우리는 화면에 뭐라도 보기 위해서는 뷰포트를 설정해야 한다.

Since we would like to use the entire render target for the output, we set the top left point to (0, 0) and width and height to be identical to the render target's size.

만약 우리가 전체 렌더 타깃을 출력하기를 바란다면, 좌상단 점을 (0, 0)으로 설정하고 넓이와 높이를 렌더 타깃 크기와 동일하게 설정하면 된다.

To do this, use the following code:

이를 위해, 다음의 코드를 사용하자:

```cpp

D3D11_VIEWPORT vp;
vp.Width = (FLOAT)width;
vp.Height = (FLOAT)height;
vp.MinDepth = 0.0f;
vp.MaxDepth = 1.0f;
vp.TopLeftX = 0;
vp.TopLeftY = 0;
g_pImmediateContext->RSSetViewports( 1, &vp );

```

# Modifying the Message Loop

We have set up the window and Direct3D 11 device, and we are ready to render.

창과 Direct3D 11 장치를 설정하였으니, 이제 렌더링할 차례다.

However, there is still a problem with our message loop: it uses **GetMessage()** to get messages.

하지만, 메시지 루프와 관련해서 문제가 하나 남아있다: 메시지를 수신하기 위해서는 **GetMessage()** 함수를 사용한다.

The problem with **GetMessage()** is that if there is no message in the queue for the application window, **GetMessage()** blocks and does not return until a message is available.

문제는, 응용프로그램 창의 큐에 어떠한 메세지도 없으면, **GetMessage()**는 블록되고 메시지를 수신할 때까지 반환하지 않는다는 것이다.

Thus, instead of doing something like rendering, our application is waiting within **GetMessage()** when the message queue is empty.

그러므로, 메시지 큐가 비었을 때 응용프로그램은 렌더링을 하는 대신, **GetMessage()** 함수에서 대기하고 있게 된다.

We can solve this problem by using **PeekMessage()** instead of **GetMessage()**.

**GetMessage()** 대신  **PeekMessage()**를 사용하여 이 문제를 해결할 수 있다.

**PeekMessage()** can retrieve a message like **GetMessage()** does, but when there is no message waiting, **PeekMessage()** returns immediately instead of blocking.

 **PeekMessage()**는 **GetMessage()**와 같이 메시지를 수신하지만, 수신할 메시지가 없으면  **PeekMessage()**는 블록되는 대신 즉시 반환한다.

We can then take this time to do some rendering.

그러면 우리는 렌더링할 시간을 확보하였다.

The modified message loop, which uses **PeekMessage()**, looks like this:

**PeekMessage()**를 사용하여 수정한 메시지 루프는 다음과 같다.

```cpp

MSG msg = {0};
while( WM_QUIT != msg.message )
{
	if( PeekMessage( &msg, NULL, 0, 0, PM_REMOVE ) )
	{
		TranslateMessage( &msg );
		DispatchMessage( &msg );
	}
	else
	{
		Render();  // Do some rendering
	}
}

```

# The Rendering Code

Rendering is done in the **Render()** function.

렌더링은 **Render()** 함수에서 수행된다.

In this tutorial, we will render the simplest scene possible, which is to fill the screen with a single color.

이 튜토리얼에서, 우리는 가장 단순한 장면 - 화면을 단일 색깔로 채운 것 - 을 렌더링 할 것이다.

In Direct3D 11, an easy way to fill the render target with a single color is to use the immediate context's **ClearRenderTargetView()** method.

Direct3D 11에서, 렌더 목표를 단일 색상으로 채우는 가장 쉬운 방법은 즉시 컨텍스트의 **ClearRenderTargetView()** 메소드를 사용하는 것이다.

First, we define an array of four floats that describe the color with which we would like to fill the screen.

첫 단계에, 우리는 화면을 채우는 데 사용할 색상을 크기 4짜리 실수 배열로 정의한다.

Then, we pass it to **ClearRenderTargetView()**.

그 다음, 그것을 **ClearRenderTargetView()**에 전달한다.

In this example, we choose a shade of blue.

예제에서는 파란색 색조를 선택하였다.

Once we fill our back buffer, we call the swap chain's **Present()** method to complete the rendering.

백 버퍼를 채우면, 렌더링을 마무리하기 위해 스왑 체인의 **Present()** 메소드를 호출한다.

**Present()** is responsible for displaying the swap chain's back buffer content onto the screen so that the user can see it.

**Present()**는 스왑 체인의 백 버퍼 내용물을 화면에 띄워 사용자가 그것을 볼 수 있게 하는 역할을 담당한다.

The **Render()** function looks like this:

**Render()** 함수는 다음과 같다:

```cpp

void Render()
{
	//
	// Clear the backbuffer
	//
	float ClearColor[4] = { 0.0f, 0.125f, 0.6f, 1.0f }; // RGBA
	g_pd3dDevice->ClearRenderTargetView( g_pRenderTargetView, ClearColor );

	g_pSwapChain->Present( 0, 0 );
}

```


