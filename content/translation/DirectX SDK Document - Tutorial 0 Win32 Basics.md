---
title: DirectX SDK Document - Tutorial 0 Win32 Basics
tags:
  - directX11
  - translation
---
---

# Summary

In this preliminary tutorial, we will go through the steps necessary to create a Win32 application.

이 예비 튜토리얼에서, 우리는 Win32 응용프로그램을 만들기 위해 필수적인 단계들을 살펴볼 것이다.

We will be setting up an empty window to prepare for Direct3D 10.

우리는 Direct3D 10을 위한 비어있는 창을 설정할 것이다.

==Source==

`(SDK root)\Samples\C++\Direct3D10\Tutorials\Tutorial00`

# Setting Up The Window

Every Windows application requires at least one window object.

모든 윈도우 응용프로그램은 최소 하나의 창 객체를 필요로 한다.

Before even getting to the Direct3D 10 specifics, our application must have a working window object.

Direct3D 10에 대한 구체적인 내용에 들어가기 전에, 먼저 애플리케이션에 제대로 동작하는 윈도우 객체가 있어야 한다.

Three things are involved:

세가지 과정이 동반된다.

1. Register a window class.

윈도우 클래스를 등록한다.

```cpp

//
// Register class
//
WNDCLASSEX wcex;
wcex.cbSize = sizeof(WNDCLASSEX);
wcex.style          = CS_HREDRAW | CS_VREDRAW;
wcex.lpfnWndProc    = WndProc;
wcex.cbClsExtra     = 0;
wcex.cbWndExtra     = 0;
wcex.hInstance      = hInstance;
wcex.hIcon          = LoadIcon(hInstance, (LPCTSTR)IDI_TUTORIAL1);
wcex.hCursor        = LoadCursor(NULL, IDC_ARROW);
wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
wcex.lpszMenuName   = NULL;
wcex.lpszClassName  = szWindowClass;
wcex.hIconSm        = LoadIcon(wcex.hInstance, (LPCTSTR)IDI_TUTORIAL1);
if( !RegisterClassEx(&wcex) )
return FALSE;

```

2. Create a window object

윈도우 객체를 만든다.

```cpp

//
// Create window
//
g_hInst = hInstance; // Store instance handle in our global variable
RECT rc = { 0, 0, 640, 480 };
AdjustWindowRect( &rc, WS_OVERLAPPEDWINDOW, FALSE );
g_hWnd = CreateWindow( szWindowClass, L"Direct3D 10 Tutorial 0: Setting Up Window", WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, rc.right - rc.left, rc.bottom - rc.top, NULL, NULL, hInstance, NULL);

if( !g_hWnd )
	return FALSE;

ShowWindow( g_hWnd, nCmdShow );

```

3. Retrieve and dispatch messages for this window.

창에 전달된 메시지를 수신하고 디스패치한다.

```cpp

//
// Main message loop
//
MSG msg = {0};
while( GetMessage( &msg, NULL, 0, 0 ) )
{
	TranslateMessage( &msg );
	DispatchMessage( &msg );
}

LRESULT CALLBACK WndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message) 
	{
		case WM_PAINT:
			hdc = BeginPaint(hWnd, &ps);
			EndPaint(hWnd, &ps);
			break;

		case WM_DESTROY:
			PostQuitMessage(0);
			break;

		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
	}

	return 0;
}


```

These are the minimum steps required to set up the window object which is required by every Windows application.

이는 모든 윈도우 응용프로그램에 필요한 창 객체를 설정하는 최소한의 단계이다.

If we complie and run this code, we will see a window with a blank white background.

이 코드를 컴파일하여 실행시키면, 우리는 빈 하얀 배경을 가진 창을 보게 될 것이다.


