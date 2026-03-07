---
title: 'FBX SDK documentation 번역'
tags:
  - graphics
  - translation
---

_Filmbox_

---

**Autodesk FBX 기술이란 무엇인가**

이 주제는 Autodesk FBX 기술과 그 기능에 대한 광범위한 설명을 제공합니다.

FBX SDK는 Autodesk FBX 기술의 일부로, 3D 콘텐츠 개발자가 3D 데이터를 가져오고 내보낼 수 있게 해주는 도구 제품군입니다. Autodesk FBX는 미디어 및 엔터테인먼트 산업에 종사하는 조직들이 다양한 2D 및 3D 디지털 콘텐츠 제작 애플리케이션을 혼합하고 매치할 수 있도록 함으로써 유연성에 기여합니다.

**3D 씬을 위한 FBX 파일 형식**

FBX 파일(.fbx)은 일반적으로 바이너리(또는 네이티브) 형식으로 저장되지만, ASCII 형식으로도 저장될 수 있습니다. 바이너리 FBX 파일과 ASCII FBX 파일 모두 .fbx 파일명 확장자를 사용합니다.

FBX 파일은 카메라, 조명, 메시, NURBS 및 3D 씬의 기타 요소에 대한 데이터를 저장합니다. Autodesk 3ds Max, Autodesk Maya, Autodesk MotionBuilder와 같은 애플리케이션은 FBX 파일에서 씬 데이터의 전체 또는 일부를 가져올 수 있습니다. 또한 씬 데이터를 FBX 파일로 내보낼 수도 있습니다. 이러한 모든 작업은 FBX SDK를 사용합니다.

다음은 ASCII 형식의 작은 FBX 파일을 축약한 버전입니다. 생략된 줄은 ...으로 표시되며, 일부 주석을 수동으로 추가했습니다. 주석은 줄의 어느 곳에서나 세미콜론(";")으로 시작합니다.

```
; FBX 7.1.0 프로젝트 파일
; Copyright (C) 1997-2010 Autodesk Inc. and/or its licensors.
; All rights reserved.
; ----------------------------------------------------
FBXHeaderExtension:  {
       ; 헤더 정보: 전역 파일 정보.
    FBXHeaderVersion: 1003
    FBXVersion: 7100
    CreationTimeStamp:  {
        Version: 1000
        Year: 2010
        Month: 1
        Day: 19
        Hour: 16
        Minute: 30
        Second: 28
        Millisecond: 884
    }
    Creator: "FBX SDK/FBX Plugins version 2011.2"
    SceneInfo: "SceneInfo::GlobalInfo", "UserData" {
 ...
}
GlobalSettings:  {
    Version: 1000
    Properties70:  {
        P: "UpAxis", "int", "Integer", "",1
        P: "UpAxisSign", "int", "Integer", "",1
        P: "FrontAxis", "int", "Integer", "",2
        P: "FrontAxisSign", "int", "Integer", "",1
        P: "CoordAxis", "int", "Integer", "",0
        P: "CoordAxisSign", "int", "Integer", "",1
        P: "OriginalUpAxis", "int", "Integer", "",-1
        P: "OriginalUpAxisSign", "int", "Integer", "",1
        P: "UnitScaleFactor", "double", "Number", "",1
        P: "OriginalUnitScaleFactor", "double", "Number", "",1
        P: "AmbientColor", "ColorRGB", "Color", "",0,0,0
        P: "DefaultCamera", "KString", "", "", "Producer Perspective"
        P: "TimeMode", "enum", "", "",6
        P: "TimeSpanStart", "KTime", "Time", "",0
        P: "TimeSpanStop", "KTime", "Time", "",46186158000
    }
}
 ...
; 객체 정의
;------------------------------------------------------------------
Definitions:  {
    Version: 100
    Count: 2251
    ObjectType: "GlobalSettings" {
        Count: 1
    }
    ObjectType: "Model" {
        Count: 86
        PropertyTemplate: "FbxNode" {
            Properties70:  {
                P: "QuaternionInterpolate", "bool", "", "",0
                P: "RotationOffset", "Vector3D", "Vector", "",0,0,0
                P: "RotationPivot", "Vector3D", "Vector", "",0,0,0
                P: "ScalingOffset", "Vector3D", "Vector", "",0,0,0
                P: "ScalingPivot", "Vector3D", "Vector", "",0,0,0
 ...}
    ObjectType: "Material" {
        Count: 1
        PropertyTemplate: "FbxSurfacePhong" {
            Properties70:  {
                P: "ShadingModel", "KString", "", "", "Phong"
                P: "MultiLayer", "bool", "", "",0
                P: "EmissiveColor", "ColorRGB", "Color", "",0,0,0
                P: "EmissiveFactor", "double", "Number", "",1
                P: "AmbientColor", "ColorRGB", "Color", "",0.2,0.2,0.2
 ...}
    Model: 21883936, "Model::Humanoid:Hips", "LimbNode" {
        Version: 232
        Properties70:  {
            P: "ScalingMin", "Vector3D", "Vector", "",1,1,1
            P: "NegativePercentShapeSupport", "bool", "", "",0
            P: "DefaultAttributeIndex", "int", "Integer", "",0
            P: "Lcl Translation", "Lcl Translation", "", "A+",-271.281097412109,-762.185852050781,528.336242675781
            P: "Lcl Rotation", "Lcl Rotation", "", "A+",-1.35128843784332,2.6148145198822,0.42334708571434
            P: "Lcl Scaling", "Lcl Scaling", "", "A+",1,0.99999988079071,1
 ...
```

**참고:** FBX 파일 형식은 문서화되어 있지 않습니다. 애플리케이션은 FBX SDK를 사용하여 씬 데이터를 FBX 파일(및 FBX SDK가 지원하는 기타 파일 형식)로 내보내고 가져와야 합니다.

**FBX 소프트웨어 개발 키트**

FBX 소프트웨어 개발 키트(FBX SDK)는 소프트웨어 개발자가 FBX 기술을 사용하는 애플리케이션을 만들거나, 기존 애플리케이션에 FBX 기술을 통합할 수 있도록 합니다.

FBX SDK는 GNU 일반 공중 사용 허가서(GPL)의 적용을 받지 않으며, 소스 코드는 공개적으로 제공되지 않습니다. Maya 및 3ds Max FBX 플러그인을 사용자 정의하기 위한 일부 소스 코드는 존재하지만, 이는 FBX SDK 자체가 아닌 FBX Extensions SDK에 패키지되어 있습니다. FBX SDK의 최신 릴리스 및 이전 버전은 http://www.autodesk.com/fbx의 Autodesk FBX 웹사이트에서 얻을 수 있습니다. FBX SDK는 Autodesk의 서면 허가 없이 재배포하거나 재패키징할 수 없습니다. FBX SDK를 사용하는 오픈 소스 프로젝트를 배포하려는 경우, 사용자가 필요한 버전의 FBX SDK를 설치할 수 있도록 Autodesk FBX 웹사이트에 대한 링크를 포함해야 합니다.

---

**샘플 FBX 애플리케이션**

**Autodesk 3ds Max 및 Autodesk Maya용 FBX 플러그인**

Autodesk 3ds Max는 사용자가 FBX 파일에 저장된 씬의 전체 또는 일부를 3ds Max 씬으로 가져오고, 3ds Max 씬의 전체 또는 일부를 FBX 파일로 내보낼 수 있도록 합니다. 다음은 3ds Max용 FBX 내보내기 대화 상자입니다:

Maya는 해당 씬에 대해 동등한 가져오기/내보내기 기능을 제공합니다. 다음은 .fbx 파일에 대한 Maya의 내보내기 대화 상자입니다:

3ds Max와 Maya 모두 FBX 기능을 플러그인으로 제공합니다. 이러한 플러그인은 FBX SDK로 작성됩니다.

**FBX Review**

FBX Review는 3D 자산 및 애니메이션을 검토하기 위한 독립 실행형 도구입니다. 이 도구를 사용하면 3D 저작 소프트웨어를 사용하지 않고도 3D 콘텐츠를 검토할 수 있습니다.

.fbx, .obj 등 다양한 형식의 3D 파일을 열고 검토할 수 있습니다. 또한 애니메이션 재생, 셰이딩 모드 전환, 씬 조명, 카메라 및 테이크 전환과 같은 많은 기능을 제공합니다.

---

**제작 파이프라인에서 FBX가 적합한 위치**

**콘텐츠 개발자가 FBX 기술로 할 수 있는 일**

콘텐츠 개발자는 영화, 텔레비전 및 게임을 위한 3D 모델링 및 애니메이션 작업을 하는 사람들입니다. 다음은 콘텐츠 개발자가 FBX 기술을 사용하는 몇 가지 방법입니다:

**씬 자산 공유(상호 운용성)** 모델 및 기타 씬 자산을 도구에서 도구로, 제작 회사에서 제작 회사로 이동합니다. 예를 들어, Studio 1은 3ds Max에서 캐릭터를 만든 다음 FBX 파일로 내보냅니다. Studio 2는 FBX 파일을 MotionBuilder로 가져와서 캐릭터에 모션 캡처 데이터를 추가한 다음 FBX 파일로 내보냅니다. Studio 3은 두 번째 파일을 Maya로 가져와서 모델의 스키닝을 수정한 다음 세 번째 FBX 파일로 내보냅니다. Studio 4는 세 번째 파일을 자체 독점 도구로 가져오는 식으로 계속됩니다.

**씬 자산 저장** 내구성 있는 파일 형식으로 씬 자산을 저장합니다. FBX의 각 새 릴리스는 이전 버전의 FBX 파일을 읽을 수 있습니다.

**애니메이션 처리** 예를 들어, 애니메이션 커브에 필터를 적용합니다.

**판매용 모델 패키징** 3D 모델 공급업체는 FBX를 파일 형식으로 사용합니다.

**디자이너가 FBX 기술로 할 수 있는 일**

건축가, 디자이너, 엔지니어 및 디자인 시각화 전문가는 Autodesk Revit Architecture와 같은 제품을 사용하여 건물 및 기타 객체를 설계하고 시각화합니다.

이러한 디자이너는 FBX 기술을 사용하여 광고 및 마케팅 자료를 준비하는 콘텐츠 개발자가 사용할 수 있는 파일 형식으로 모델, 메타데이터 및 기타 자산을 저장합니다.

**FBX 기술을 지원하는 애플리케이션**

다음 Autodesk 제품은 FBX 기술을 사용하여 파일을 가져오고 내보냅니다:

|제품|설명|
|---|---|
|Autodesk 3ds Max|3D 애니메이션, 모델링 및 렌더링 솔루션. FBX 파일을 가져오고 내보내는 플러그인 포함.|
|Autodesk Maya|3D 모델링, 애니메이션 및 렌더링 솔루션. FBX 파일을 가져오고 내보내는 플러그인 포함.|
|Autodesk Maya LT|3D 모델링 및 애니메이션 소프트웨어. FBX 파일을 가져오고 내보냄.|
|Autodesk MotionBuilder|3D 캐릭터 애니메이션을 위한 생산성 제품군. FBX 파일을 가져오고 내보냄.|
|Autodesk Mudbox|3D 모델러 및 텍스처 아티스트를 위한 디지털 조각 및 텍스처 페인팅 소프트웨어. FBX 파일을 가져오고 내보냄.|
|Autodesk Flame|실시간 시각 효과 디자인 및 합성 시스템. FBX 파일을 가져오고 내보냄.|
|Autodesk Smoke|SD, HD, 2K 필름 이상을 위한 통합 편집 및 마무리 시스템. FBX 파일을 가져오고 내보냄.|
|AutoCAD Revit Architecture|빌딩 정보 모델링(BIM) 애플리케이션. FBX 파일을 내보냄.|
|AutoCAD|범용 CAD 모델링 패키지. FBX 파일을 가져오고 내보냄.|

많은 타사 소프트웨어 제품도 FBX SDK를 사용하여 파일을 가져오고 내보냅니다. 자세한 내용은 __http://www.autodesk.com/fbx__를 참조하십시오.

---

**새로운 기능/변경 사항**

이 섹션은 FBX SDK의 각 릴리스 간의 중요한 변경 사항에 대한 개요를 제공합니다.

FBX SDK의 이전 버전 이후의 모든 변경 사항에 대한 세부 정보는 FBX SDK 설치 루트 디렉토리에 있는 readme.txt 파일에 있습니다.

**더 이상 사용되지 않는 클래스 및 함수 피하기**

FBX SDK의 각 릴리스에서 더 이상 사용되지 않는 클래스 및 함수는 `K_DEPRECATED`로 선언됩니다:

```
K_DEPRECATED KFbxTakeNode* GetDefaultTakeNode();
```

더 이상 사용되지 않는 함수를 계속 사용할 수 있지만 다음 사항에 유의하십시오:

- 컴파일러에서 경고가 발생합니다.
- 현재 릴리스에서 더 이상 사용되지 않는 함수는 다음 릴리스에서 완전히 제거됩니다.

**이 섹션의 페이지**

- FBX SDK 2020
- FBX SDK 2019
- FBX SDK 2018
- FBX SDK 2017
- FBX SDK 2016
- FBX SDK 2015
- FBX SDK 2014
- FBX SDK 2013
- FBX SDK 2012
- FBX SDK 2011

---

**플랫폼 요구 사항**

FBX SDK는 다음 플랫폼의 32비트 및 64비트 버전에서 실행됩니다:

|플랫폼|요구 사항|
|---|---|
|Microsoft Windows|Windows 7.0<br>Windows 8.0 / Windows 8.1<br>Windows 10|
|Windows Store 앱|Windows 8.0 이상.|
|Linux|GCC 버전 9.3 이상을 제공하는 모든 Linux 구현.|
|Mac OS|Intel 프로세서(64비트만) 또는 Apple M1(ARM64)이 탑재된 버전 10.8 이상|
|iOS|버전 7.0. ARMv7, ARMv7s 및 ARM64 아키텍처 지원.|

자세한 내용은 __권장 개발 환경__을 참조하십시오.

---

**지원되는 파일 형식**

FBX SDK는 다음을 수행할 수 있습니다:

- FBX 파일 형식 버전 7.5, 7.4, 7.3, 7.2, 7.1, 7.0, 6.1 및 6.0과 호환되는 FBX 파일을 가져옵니다.
- FBX 파일 형식 버전 7.5, 7.4, 7.3, 7.2, 7.1, 7.0 및 6.1과 호환되는 FBX 파일을 내보냅니다.

FBX SDK는 다음 애플리케이션과 호환되는 FBX 파일을 가져오고 내보냅니다:

|소프트웨어|버전|
|---|---|
|MotionBuilder|버전 5.5 이상.|
|FBX Plug-in for 3ds Max|모든 버전.|
|FBX Plug-in for Maya|모든 버전.|
|FBX Plug-in for Maya LT|모든 버전. 참고: Maya LT 2016에서 FBX 파일을 내보낼 때 이제 한 번에 최대 100,000개의 폴리곤을 내보낼 수 있습니다. 씬 또는 선택한 객체가 100,000개 제한을 초과하면 오류가 표시됩니다. 자세한 내용은 Maya LT 도움말을 참조하십시오.|
|Mudbox|버전 2010 이상.|
|Flame|버전 8.0 이상.|
|Smoke|버전 6.0 이상.|
|Revit Architecture|버전 2009.1 이상.|
|AutoCAD|버전 2011 이상.|

FBX SDK는 다음 파일 형식의 파일도 가져오고 내보냅니다:

|파일 형식|버전|
|---|---|
|Autodesk AutoCAD DXF (.dxf)|버전 13 이하.|
|Collada DAE (.dae)|버전 1.5 이하.|
|Alias OBJ (.obj)|모든 버전.|

**참고:** FBX SDK 2012.0부터 .3ds 파일 형식 쓰기가 중단되었습니다. 그러나 .3ds 파일 리더는 계속 유지됩니다.

---

**지원되는 씬 요소**

FBX SDK를 사용하면 씬(`FbxScene`)의 다음 요소에 액세스하거나, 생성하거나, 수정할 수 있습니다:

- 메시 - `FbxMesh`
- 상세도(LOD) 그룹 - `FbxLodGroup`
- 카메라(3D용 스테레오 카메라 포함) - `FbxCamera`
- 조명 및 고보 - `FbxLight`, `FbxGobo`
- NURBS - `FbxNurbs`, `FbxNurbsCurve`, `FbxNurbsSurface`, `FbxTrimNurbsSurface`
- 지오메트리에 대한 텍스처 매핑 - `FbxTexture`
- 지오메트리에 대한 머티리얼 매핑 - `FbxSurfaceMaterial`
- 제약 조건 - `FbxConstraint`
- 지오메트리의 제어점에 대한 정점 캐시 애니메이션 - `FbxDeformer`
- Up-Axis(X/Y/Z) 및 씬 스케일링(단위)을 제공하는 씬 설정 - `FbxGlobalSettings`, `FbxAxisSystem`
- 위치, 회전, 스케일, 부모를 포함한 변환 데이터 - `FbxNode`
- 마커 - `FbxMarker`
- 선 - `FbxLine`
- 스켈레톤 세그먼트(루트, 림, 림 노드) - `FbxSkeleton`
- 애니메이션 커브 - `FbxAnimCurve`
- 노드 목록(본 및 지오메트리)에 대한 레스트 및 바인드 포즈 - `FbxPose`

---

**정보 및 기술 지원**

이 주제는 정보 및 기술 지원을 위한 참조 자료 세트를 제공합니다.

FBX SDK 사용자를 위해 Autodesk FBX 웹사이트, FBX Developer Help, C++ Reference, Autodesk Developer Network 및 AREA 토론 포럼을 포함한 다양한 정보 출처를 이용할 수 있습니다.

**FBX Developer Help**

현재 읽고 계신 문서가 FBX Developer Help입니다. 이 문서의 목적은 FBX SDK의 핵심 개념에 익숙해지도록 하는 것입니다. 이 주제는 통찰력 있는 샘플 프로그램이나 C++ Reference 내의 관련 문서를 안내합니다. 마지막 순간의 문서 변경 사항에 대해서는 FBX SDK 설치의 루트 폴더에 있는 readme.txt 파일도 참조하십시오.

**C++ 레퍼런스**

C++ Reference에는 각 클래스, 멤버 함수, 열거형 등에 대한 API 문서가 포함되어 있습니다. FBX SDK는 Autodesk 3ds Max 및 Autodesk Maya용 FBX 플러그인을 개발하는 데 사용되었습니다. 또한 FBX Converter 및 FBX for QuickTime 프로그램을 개발하는 데도 사용되었습니다. 이러한 도구의 기능은 FBX SDK의 기능에 대한 좋은 소개를 제공합니다(이러한 도구에 대한 링크는 **http://www.autodesk.com/fbx** 참조).

**레퍼런스 가이드 명명 규칙**

레퍼런스 가이드의 헤더 파일과 샘플 프로그램은 일반적으로 다음 명명 규칙을 따릅니다.

|접두사|참고|
|---|---|
|`Fbx`|대부분의 FBX SDK 클래스 이름은 Fbx로 시작합니다. 예: `FbxNode`, `FbxScene`, `FbxCamera`|
|`p`|멤버 함수에 전달되는 매개변수는 소문자 "p"로 시작합니다. 예: `pWriteFileFormat`, `pScene`, `pFilename`|
|`l`|지역 변수는 소문자 "l"로 시작합니다. 예: `lWriteFileFormat`, `lScene`, `lFilename`|
|`g`|전역 변수는 소문자 "g"로 시작합니다. 예: `gStart`, `gStop`, `gCurrentTime`|
|`m`|멤버 데이터(멤버 변수)는 소문자 "m"으로 시작합니다. 예: `mDescription`, `mImportname`, `mSelect`|

**Autodesk Developer Network**

FBX SDK에 대한 기술 지원은 Autodesk Developer Network(ADN) Sparks 타사 개발자 프로그램을 통해 제공됩니다. 프로그램 세부 정보, 혜택 및 가격은 **Autodesk Developer Network** 웹 페이지에서 확인할 수 있습니다.

**토론 포럼**

개발자 및 기타 사용자를 위한 무료 사용자 간 토론 포럼을 이용하려면 디지털 엔터테인먼트 및 시각화를 위한 Autodesk 커뮤니티인 AREA의 FBX 섹션을 방문하십시오: **https://forums.autodesk.com/t5/fbx-forum/bd-p/area-b64**

---
---

**시작하기**

이 섹션은 FBX SDK를 설치하고 구성하는 방법에 대한 정보를 제공합니다. 또한 FBX SDK에 익숙해지는 데 도움이 되는 기본 프로그램도 포함되어 있습니다.

**이 섹션의 페이지**

- 설치 및 구성
- 첫 번째 FBX SDK 프로그램

---

**설치 및 구성**

이 섹션은 개발 플랫폼에 따라 FBX SDK를 설치하고 구성하는 방법을 설명합니다.

**참고:** FBX SDK에 대한 C++ 인터페이스 대신 Python FBX를 사용할 계획이라면 __Scripting with Python FBX__를 참조하십시오.

**이 섹션의 페이지**

- 권장 개발 환경
- 디렉토리 구조
- Windows용 FBX SDK 구성
- Linux용 FBX SDK 구성
- Mac OS용 FBX SDK 구성

---

**권장 개발 환경**

다음 표는 FBX SDK로 플러그인, 변환기 및 기타 애플리케이션을 개발하는 데 권장되는 플랫폼과 컴파일러를 나열합니다:

|지원되는 플랫폼|지원되는 개발 환경 또는 컴파일러|
|---|---|
|Windows 7.0|Visual Studio 2015, Visual Studio 2017, Visual Studio 2019|
|Windows 8.0 / Windows 8.1||
|Windows 10.0||
|Linux|GCC 버전 9.3 이상을 제공하는 모든 구현.|
|Mac OS X|Clang (Xcode 12.0)|

**참고:**

- 플랫폼 또는 컴파일러가 위에 나열되어 있지 않은 경우, FBX SDK를 사용하는 프로그램을 컴파일하지 못할 수 있습니다.
- FBX SDK로 개발된 애플리케이션을 실행할 수 있는 플랫폼에 대한 정보는 __플랫폼 요구 사항__을 참조하십시오.

---

**디렉토리 구조**

FBX SDK의 디렉토리 구조는 지원되는 모든 플랫폼에서 동일합니다: **Windows용 FBX SDK 구성**, **Mac OS용 FBX SDK 구성** 및 **Linux용 FBX SDK 구성**.

| 디렉토리 경로                   | 설명                                                         |
| ------------------------- | ---------------------------------------------------------- |
| \<yourFBXSDKpath>         | FBX 배포 디렉토리의 루트. readme 파일, 라이선스 텍스트 및 제거 프로그램이 포함되어 있습니다. |
| \<yourFBXSDKpath>\samples | 각각 자체 하위 폴더에 있는 샘플 프로그램. CMake 파일, 소스 등이 포함되어 있습니다.        |
| \<yourFBXSDKpath>\include | FBX SDK용 헤더 파일.                                            |
| \<yourFBXSDKpath>\lib     | FBX SDK용 런타임 라이브러리.                                        |

---

**Windows용 FBX SDK 구성**

**FBX SDK 다운로드 및 설치**

Windows에서 FBX SDK를 다운로드하고 설치하려면:

1. http://www.autodesk.com/fbx로 이동합니다.
2. GET FBX SDK를 클릭하여 FBX SDK 다운로드 페이지에 액세스합니다.
3. Visual Studio 버전에 맞는 Windows용 FBX SDK를 선택하고 설치 파일을 다운로드합니다.
4. 설치 프로그램을 실행하고 지침을 따릅니다.
5. 설치 프로그램을 통해 대상 폴더를 지정할 수 있습니다. 새 폴더 또는 빈 폴더를 지정하십시오. 이 주제에서는 **<yourFBXSDKpath>**라고 하며, FBX SDK의 배포 디렉토리입니다.
6. <yourFBXSDKpath>\readme.txt 파일을 읽으십시오. readme.txt 파일에는 이전 버전 이후 FBX SDK의 변경 사항에 대한 자세한 정보와 마지막 순간의 문서가 포함되어 있습니다.

**참고:**

- 설치 프로그램은 Windows 레지스트리나 Windows 시작 메뉴를 수정하지 않습니다.
- 각 버전을 별도의 폴더에 설치하는 경우 컴퓨터에 FBX SDK의 여러 버전을 설치할 수 있습니다.

**FBX SDK 제거**

컴퓨터에서 FBX SDK를 제거하려면:

<yourFBXSDKpath>\uninstall.exe를 실행합니다.

**Windows용 런타임 라이브러리**

Visual Studio 버전과 대상 애플리케이션의 프로세서 아키텍처에 적합한 런타임 라이브러리를 사용해야 합니다. FBX 라이브러리는 Visual Studio 버전, 프로세서 유형 및 빌드 모드에 따라 <yourFBXSDKpath>\lib 아래의 하위 디렉토리로 구성됩니다:

```
<yourFBXSDKpath>\lib\<compiler_version>\<processor_type>\<build_mode>
```

예를 들어:

```
<yourFBXSDKpath>\lib\vs2015\x64\release
```

이러한 각 하위 디렉토리에는 서로 다른 플래그로 컴파일된 여러 버전의 라이브러리가 포함되어 있습니다. 다음 표는 FBX SDK 라이브러리 파일 이름과 설명을 제공합니다.

**참고:** 동적 .lib 파일은 애플리케이션 실행 시 해당 .dll 파일을 사용할 수 있어야 합니다(아래 표의 애플리케이션 종속성 열 참조). 애플리케이션에서 FBX SDK의 동적 라이브러리 버전을 사용하려는 경우 실행 파일과 함께 적절한 .dll을 배포해야 합니다.

|라이브러리 파일|라이브러리 설명|필요한 런타임 라이브러리 옵션|필요한 전처리기 정의|
|---|---|---|---|
|libfbxsdk.lib|동적 링킹||FBXSDK_SHARED|
|libfbxsdk-md.lib|정적 링킹|/MD||
|libfbxsdk-mt.lib|정적 링킹|/MT||

다음 표는 관련 런타임 라이브러리 옵션에 대한 설명을 제공합니다. 이러한 설명은 http://msdn.microsoft.com/en-us/library/2kzt1wy3.aspx에서도 찾을 수 있습니다.

|런타임 라이브러리 옵션|설명|
|---|---|
|MT|애플리케이션이 런타임 라이브러리의 멀티스레드 정적 버전을 사용하도록 합니다. _MT를 정의하고 컴파일러가 라이브러리 이름 LIBCMT.lib를 .obj 파일에 배치하여 링커가 LIBCMT.lib를 사용하여 외부 심볼을 확인하도록 합니다.|
|MD|애플리케이션이 런타임 라이브러리의 멀티스레드 및 DLL 관련 버전을 사용하도록 합니다. _MT 및 _DLL을 정의하고 컴파일러가 라이브러리 이름 MSVCRT.lib를 .obj 파일에 배치하도록 합니다. 이 옵션으로 컴파일된 애플리케이션은 MSVCRT.lib에 정적으로 링크됩니다. 이 라이브러리는 링커가 외부 참조를 확인할 수 있도록 하는 코드 계층을 제공합니다. 실제 작업 코드는 MSVCR100.DLL에 포함되어 있으며, 이는 MSVCRT.lib와 링크된 애플리케이션에서 실행 시 사용할 수 있어야 합니다.|

**참고:** 이러한 라이브러리는 모두 Microsoft의 멀티스레드 C 라이브러리에 링크될 수 있습니다. 그러나 FBX SDK 코드는 스레드 안전이 보장되지 않습니다.

**Visual Studio 구성**

이 섹션의 지침은 Visual Studio 2010을 기반으로 합니다.

**참고** FBX SDK용 샘플 프로그램을 빌드하고 실행하려면 샘플 프로그램 빌드 및 실행을 참조하십시오.

FBX SDK를 사용하는 새 Visual Studio 솔루션을 만들려면:

1. Visual Studio를 시작합니다.
    
2. 새 프로젝트를 만들려면 파일 메뉴에서 새로 만들기 > 프로젝트를 선택합니다.
    
3. Visual C++ > Win32를 선택합니다.
    
4. 평소와 같이 계속한 다음 마침을 클릭합니다. 새 프로젝트와 솔루션이 나타납니다.
    
5. 프로젝트 > 속성을 선택합니다. 속성 페이지 대화 상자가 나타납니다.
    
6. 속성 페이지 대화 상자의 왼쪽 속성 트리에서 구성 속성 > C/C++ > 일반을 선택합니다.
    
7. 대화 상자 오른쪽의 속성 시트에서 추가 포함 디렉터리 드롭다운 상자에서 <편집..>을 선택합니다. 추가 포함 디렉터리 대화 상자가 나타납니다.
    
8. 추가 포함 디렉터리 대화 상자 상단의 목록 상자에서 디렉터리를 찾아볼 수 있는 컨트롤이 나타날 때까지 맨 위의 빈 줄을 클릭합니다.
    
9. 이 컨트롤을 사용하여 <yourFBXSDKpath>\include 디렉터리의 전체 경로를 추가하고 확인을 클릭합니다.
    
10. 속성 페이지 대화 상자의 왼쪽 트리에서 코드 생성을 선택합니다.
    
11. 오른쪽 속성 시트에서 런타임 라이브러리 드롭다운 상자에서 프로젝트에 대한 런타임 라이브러리 유형을 선택합니다. 목록은 Visual C++ 컴파일러 옵션에 해당합니다: /MD, /MDd, /MT, /MTd 등. 모든 Visual Studio 버전에서 모든 컴파일러 옵션을 사용할 수 있는 것은 아닙니다(Windows용 FBX SDK 구성 참조).
    
12. 속성 페이지 대화 상자에서 링커 > 일반을 선택합니다.
    
13. 추가 라이브러리 종속성 드롭다운 상자에서 <편집..>을 선택합니다. 추가 라이브러리 디렉터리 대화 상자가 나타납니다.
    
14. FBX SDK 배포의 <yourFBXSDKpath>\lib 폴더에 대한 전체 경로를 입력합니다.
    
15. 속성 페이지 대화 상자에서 링커 > 입력을 선택합니다. 추가 종속성 드롭다운 상자에서 <편집>을 선택합니다. 추가 종속성 대화 상자가 나타납니다. 적절한 FBX SDK 라이브러리를 추가합니다. 사용 가능한 FBX SDK 라이브러리 파일을 설명하는 표는 Windows용 FBX SDK 구성을 참조하십시오.
    
16. 이전 단계에서 정적 링킹을 사용하는 FBX SDK 라이브러리의 디버그 버전을 선택한 경우 다음을 수행해야 합니다:
    
    - 특정 기본 라이브러리 무시 드롭다운 상자에서 <편집>을 선택합니다. 특정 기본 라이브러리 무시 대화 상자가 나타납니다.
    - LIBCMT를 입력하고 확인을 클릭합니다.
    - 추가 종속성 드롭다운 상자에서 <편집>을 선택합니다. 추가 종속성 대화 상자가 나타납니다.
    - wininet.lib를 입력하고 확인을 클릭합니다.

**참고:** FBX SDK의 동적 라이브러리 버전을 사용하는 경우 프로젝트의 전처리기 정의에 FBXSDK_SHARED를 추가하십시오.

**프로젝트의 전처리기 정의에 대한 중요 참고 사항**

FBX SDK의 동적 라이브러리 버전을 사용하는 경우 프로젝트의 전처리기 정의에 FBXSDK_SHARED를 추가하십시오. Visual Studio에서 이를 수행하려면 프로젝트에서 프로젝트 > 속성 > 구성 속성 > C/C++ > 전처리기를 선택하고 전처리기 정의 필드를 편집합니다.

---

**첫 번째 FBX SDK 프로그램**

이 주제는 첫 번째 FBX SDK 프로그램에 대한 기본 개요를 제공합니다.

이 프로그램은 정적으로 링크된 버전의 FBX SDK를 사용합니다. 환경에 맞게 FBX SDK를 설치하고 구성하는 방법에 대한 추가 정보는 설치 및 구성을 참조하십시오.

다음 FBX SDK 프로그램은 다음 작업 방법에 대한 개요를 제공합니다:

- FBX SDK 메모리 관리 객체를 인스턴스화합니다. (FbxManager)
- FBX 파일의 내용을 씬으로 가져옵니다. (FbxIOSettings, FbxImporter, FbxScene)
- 씬의 요소 계층 구조를 순회합니다. (FbxScene, FbxNode, FbxNodeAttribute)
- 씬의 요소에 대한 기본 정보에 액세스하고 출력합니다. (FbxNode, FbxNodeAttribute, FbxString)

**객체 관리**

**관련 주제:** FBX SDK 관리자를 사용한 메모리 관리

FBX SDK에서 조작되는 대부분의 객체는 SDK의 메모리 관리자 객체(FbxManager)에 대한 참조와 함께 인스턴스화됩니다. 일반적으로 FBX SDK를 사용하는 프로그램에서 가장 먼저 생성되는 객체 중 하나이며, FbxManager::Create() 함수로 인스턴스화됩니다. 프로그램에는 FbxManager의 인스턴스가 하나만 필요합니다. FbxManager::Destroy() 메서드를 사용하여 FbxManager의 인스턴스가 소멸되면, 이와 함께 생성된 다른 모든 FBX SDK 객체도 소멸됩니다.

```cpp
#include <fbxsdk.h>

// ...

/**
 * 메인 함수 - 하드코딩된 fbx 파일을 로드하고,
 * 그 내용을 xml 형식으로 stdout에 출력합니다.
 */
int main(int argc, char** argv) {

    // 다음 파일명을 적절한 파일명 값으로 변경하십시오.
    const char* lFilename = "file.fbx";

    // SDK 관리자를 초기화합니다. 이 객체는 메모리 관리를 처리합니다.
    FbxManager* lSdkManager = FbxManager::Create();
```

**FBX 파일의 내용 가져오기**

**관련 주제:**

- 지원되는 파일 형식
- IO 설정
- 씬 가져오기

FBX 파일의 내용을 가져오려면 FbxIOSettings 객체와 FbxImporter 객체를 생성해야 합니다. FbxImporter 객체는 가져올 파일의 파일명과 가져오기 요구 사항에 맞게 적절히 구성된 FbxIOSettings 객체를 제공하여 초기화됩니다({ IO 설정 } 참조).

```cpp
// IO 설정 객체를 생성합니다.
FbxIOSettings *ios = FbxIOSettings::Create(lSdkManager, IOSROOT);
lSdkManager->SetIOSettings(ios);

// SDK 관리자를 사용하여 임포터를 생성합니다.
FbxImporter* lImporter = FbxImporter::Create(lSdkManager,"");

// 첫 번째 인수를 임포터의 파일명으로 사용합니다.
if(!lImporter->Initialize(lFilename, -1, lSdkManager->GetIOSettings())) {
    printf("Call to FbxImporter::Initialize() failed.\n");
    printf("Error returned: %s\n\n", lImporter->GetStatus().GetErrorString());
    exit(-1);
}
```

FbxImporter 객체는 제공된 FbxScene 객체를 FBX 파일에 포함된 요소로 채웁니다. FbxScene::Create() 함수의 두 번째 매개변수로 빈 문자열이 전달되는 것을 관찰하십시오. FBX SDK에서 생성된 객체에는 임의의 고유하지 않은 이름을 지정할 수 있으며, 이를 통해 사용자나 다른 프로그램이 내보낸 후 객체를 식별할 수 있습니다. FbxScene이 채워진 후에는 FbxImporter를 안전하게 소멸시킬 수 있습니다.

```cpp
// 가져온 파일로 채울 수 있도록 새 씬을 생성합니다.
FbxScene* lScene = FbxScene::Create(lSdkManager,"myScene");

// 파일의 내용을 씬으로 가져옵니다.
lImporter->Import(lScene);

// 파일을 가져왔으므로 임포터를 제거합니다.
lImporter->Destroy();
```

**씬 탐색**

**관련 주제:**

- FBX 씬
- FBX 노드
- FBX 노드 속성
- 두 씬 병합

FbxScene 객체는 씬 내에 존재하는 요소의 컨테이너 역할을 합니다. 가져오거나 내보낸 파일당 FbxScene 객체는 하나만 있을 수 있습니다. 씬에는 메시, 조명, 카메라, 스켈레톤, NURBS(몇 가지만 언급하자면) 등 다양한 요소가 포함될 수 있습니다. FbxScene의 요소는 FbxNode의 계층적 트리로 구성됩니다. 씬의 루트 노드는 FbxScene::GetRootNode()를 통해 액세스됩니다. 씬의 루트 노드는 씬을 파일로 내보낼 때 저장되지 않으며, 그 자식만 저장됩니다. 노드의 자식은 FbxNode::GetChild()를 통해 액세스할 수 있습니다. 마찬가지로 노드의 부모는 FbxNode::GetParent()를 통해 액세스할 수 있습니다. 개념적으로 FbxNode는 하나 이상의 씬 요소에 대한 컨테이너 역할을 합니다. 예를 들어, 씬의 한 FbxNode에는 카메라가 포함될 수 있고, 다른 FbxNode에는 메시가 포함될 수 있습니다. FBX SDK에서 메시, 조명, 카메라, 스켈레톤, NURBS, 애니메이션 커브 등과 같은 씬 요소는 FbxNodeAttribute에서 파생된 클래스로 정의됩니다. FbxNode당 둘 이상의 FbxNodeAttribute가 있을 수 있습니다.

```cpp
// 씬의 노드와 그 속성을 재귀적으로 출력합니다.
// 루트 노드는 속성을 포함해서는 안 되므로
// 출력하지 않습니다.
FbxNode* lRootNode = lScene->GetRootNode();
if(lRootNode) {
    for(int i = 0; i < lRootNode->GetChildCount(); i++)
        PrintNode(lRootNode->GetChild(i));
}
// SDK 관리자와 그것이 처리하던 다른 모든 객체를 소멸시킵니다.
lSdkManager->Destroy();
```

FbxNode는 로컬 이동(FbxNode::LclTranslation), 회전(FbxNode::LclRotation) 및 스케일링(FbxNode::LclScaling) 속성에 대한 액세스를 제공합니다. 이러한 속성은 현재 노드의 위치, 방향 및 스케일을 얻기 위해 부모 노드의 위치, 방향 및 스케일에 적용되는 변환을 나타냅니다.

```cpp
/**
 * 노드, 그 속성 및 모든 자식을 재귀적으로 출력합니다.
 */
void PrintNode(FbxNode* pNode) {
    PrintTabs();
    const char* nodeName = pNode->GetName();
    FbxDouble3 translation = pNode->LclTranslation.Get();
    FbxDouble3 rotation = pNode->LclRotation.Get();
    FbxDouble3 scaling = pNode->LclScaling.Get();

    // 노드의 내용을 출력합니다.
    printf("<node name='%s' translation='(%f, %f, %f)' rotation='(%f, %f, %f)' scaling='(%f, %f, %f)'>\n",
        nodeName,
        translation[0], translation[1], translation[2],
        rotation[0], rotation[1], rotation[2],
        scaling[0], scaling[1], scaling[2]
        );
    numTabs++;

    // 노드의 속성을 출력합니다.
    for(int i = 0; i < pNode->GetNodeAttributeCount(); i++)
        PrintAttribute(pNode->GetNodeAttributeByIndex(i));

    // 자식을 재귀적으로 출력합니다.
    for(int j = 0; j < pNode->GetChildCount(); j++)
        PrintNode(pNode->GetChild(j));

    numTabs--;
    PrintTabs();
    printf("</node>\n");
}
```

**첫 번째 프로그램**

```cpp
#include <fbxsdk.h>

/* 탭 문자("\t") 카운터 */
int numTabs = 0;

/**
 * 필요한 수의 탭을 출력합니다.
 */
void PrintTabs() {
    for(int i = 0; i < numTabs; i++)
        printf("\t");
}

/**
 * 속성 타입에 기반한 문자열 표현을 반환합니다.
 */
FbxString GetAttributeTypeName(FbxNodeAttribute::EType type) {
    switch(type) {
        case FbxNodeAttribute::eUnknown: return "unidentified";
        case FbxNodeAttribute::eNull: return "null";
        case FbxNodeAttribute::eMarker: return "marker";
        case FbxNodeAttribute::eSkeleton: return "skeleton";
        case FbxNodeAttribute::eMesh: return "mesh";
        case FbxNodeAttribute::eNurbs: return "nurbs";
        case FbxNodeAttribute::ePatch: return "patch";
        case FbxNodeAttribute::eCamera: return "camera";
        case FbxNodeAttribute::eCameraStereo: return "stereo";
        case FbxNodeAttribute::eCameraSwitcher: return "camera switcher";
        case FbxNodeAttribute::eLight: return "light";
        case FbxNodeAttribute::eOpticalReference: return "optical reference";
        case FbxNodeAttribute::eOpticalMarker: return "marker";
        case FbxNodeAttribute::eNurbsCurve: return "nurbs curve";
        case FbxNodeAttribute::eTrimNurbsSurface: return "trim nurbs surface";
        case FbxNodeAttribute::eBoundary: return "boundary";
        case FbxNodeAttribute::eNurbsSurface: return "nurbs surface";
        case FbxNodeAttribute::eShape: return "shape";
        case FbxNodeAttribute::eLODGroup: return "lodgroup";
        case FbxNodeAttribute::eSubDiv: return "subdiv";
        default: return "unknown";
    }
}

/**
 * 속성을 출력합니다.
 */
void PrintAttribute(FbxNodeAttribute* pAttribute) {
    if(!pAttribute) return;

    FbxString typeName = GetAttributeTypeName(pAttribute->GetAttributeType());
    FbxString attrName = pAttribute->GetName();
    PrintTabs();
    // 참고: FbxString의 문자 배열을 검색하려면 Buffer() 메서드를 사용하십시오.
    printf("<attribute type='%s' name='%s'/>\n", typeName.Buffer(), attrName.Buffer());
}

/**
 * 노드, 그 속성 및 모든 자식을 재귀적으로 출력합니다.
 */
void PrintNode(FbxNode* pNode) {
    PrintTabs();
    const char* nodeName = pNode->GetName();
    FbxDouble3 translation = pNode->LclTranslation.Get();
    FbxDouble3 rotation = pNode->LclRotation.Get();
    FbxDouble3 scaling = pNode->LclScaling.Get();

    // 노드의 내용을 출력합니다.
    printf("<node name='%s' translation='(%f, %f, %f)' rotation='(%f, %f, %f)' scaling='(%f, %f, %f)'>\n",
        nodeName,
        translation[0], translation[1], translation[2],
        rotation[0], rotation[1], rotation[2],
        scaling[0], scaling[1], scaling[2]
        );
    numTabs++;

    // 노드의 속성을 출력합니다.
    for(int i = 0; i < pNode->GetNodeAttributeCount(); i++)
        PrintAttribute(pNode->GetNodeAttributeByIndex(i));

    // 자식을 재귀적으로 출력합니다.
    for(int j = 0; j < pNode->GetChildCount(); j++)
        PrintNode(pNode->GetChild(j));

    numTabs--;
    PrintTabs();
    printf("</node>\n");
}

/**
 * 메인 함수 - 하드코딩된 fbx 파일을 로드하고,
 * 그 내용을 xml 형식으로 stdout에 출력합니다.
 */
int main(int argc, char** argv) {

    // 다음 파일명을 적절한 파일명 값으로 변경하십시오.
    const char* lFilename = "file.fbx";

    // SDK 관리자를 초기화합니다. 이 객체는 모든 메모리 관리를 처리합니다.
    FbxManager* lSdkManager = FbxManager::Create();

    // IO 설정 객체를 생성합니다.
    FbxIOSettings *ios = FbxIOSettings::Create(lSdkManager, IOSROOT);
    lSdkManager->SetIOSettings(ios);

    // SDK 관리자를 사용하여 임포터를 생성합니다.
    FbxImporter* lImporter = FbxImporter::Create(lSdkManager,"");

    // 첫 번째 인수를 임포터의 파일명으로 사용합니다.
    if(!lImporter->Initialize(lFilename, -1, lSdkManager->GetIOSettings())) {
        printf("Call to FbxImporter::Initialize() failed.\n");
        printf("Error returned: %s\n\n", lImporter->GetStatus().GetErrorString());
        exit(-1);
    }

    // 가져온 파일로 채울 수 있도록 새 씬을 생성합니다.
    FbxScene* lScene = FbxScene::Create(lSdkManager,"myScene");

    // 파일의 내용을 씬으로 가져옵니다.
    lImporter->Import(lScene);

    // 파일을 가져왔으므로 임포터를 제거합니다.
    lImporter->Destroy();

    // 씬의 노드와 그 속성을 재귀적으로 출력합니다.
    // 루트 노드는 속성을 포함해서는 안 되므로
    // 출력하지 않습니다.
    FbxNode* lRootNode = lScene->GetRootNode();
    if(lRootNode) {
        for(int i = 0; i < lRootNode->GetChildCount(); i++)
            PrintNode(lRootNode->GetChild(i));
    }
    // SDK 관리자와 그것이 처리하던 다른 모든 객체를 소멸시킵니다.
    lSdkManager->Destroy();
    return 0;
}
```

---

**샘플 프로그램**

FBX SDK는 지원되는 모든 플랫폼에서 실행되는 샘플 프로그램과 함께 제공됩니다.

**기능 중심 프로그램**

이러한 샘플은 FBX SDK의 특정 기능을 보여줍니다. 이러한 각 샘플의 폴더는 \<yourFBXSDKpath>\samples\에 있습니다. 각 폴더에는 샘플을 빌드하고 실행하는 데 도움이 되는 Visual Studio 프로젝트 파일(Windows만 해당) 또는 makefile(Mac OS 또는 Linux)을 생성하는 데 사용되는 CMakeList.txt 파일이 포함되어 있습니다. __샘플 프로그램 빌드 및 실행__을 참조하십시오.

**튜토리얼 프로그램**

튜토리얼 프로그램은 FBX SDK를 처음 사용하는 개발자를 대상으로 합니다. FBX SDK를 효과적으로 사용하는 방법을 설명하는 순서로 FBX 기능을 소개합니다. __튜토리얼 프로그램__을 참조하십시오.

---

**튜토리얼 프로그램**

이러한 튜토리얼 프로그램은 FBX SDK를 학습하는 프로그래머를 대상으로 합니다. 이러한 튜토리얼은 Windows에서만 실행됩니다. 각 튜토리얼 프로그램은:

- 학습자에게 적합한 순서로 FBX 기능과 요구 사항을 소개합니다.
- 실용적인 목적을 가지고 있습니다.
- 애플리케이션 내의 일반적인 워크플로를 보여줍니다.
- 의미 있는 결과를 보여줍니다.
- 이 FBX Developer Help의 다음 튜토리얼 섹션 중 하나 이상에 해당합니다:

|튜토리얼 프로그램|튜토리얼 섹션|설명|
|---|---|---|
|**Tutorial: ImportExport**|**씬 가져오기 및 내보내기**|파일을 가져오는 방법과 파일을 내보내는 방법을 보여줍니다.|
|**Tutorial: SceneTreeView**|**노드 및 씬 그래프**|FBX 씬의 모든 노드를 순회하는 방법과 각 노드의 내용을 결정하는 방법, 즉 노드에 카메라, 조명, 메시 등이 포함되어 있는지 확인하는 방법을 보여줍니다.|
|**Tutorial: CubeCreator**|**메시, 머티리얼 및 텍스처**|메시에 텍스처와 머티리얼을 추가하는 방법을 보여줍니다.|
|**Tutorial: CubeCreator**|**애니메이션**|씬에서 메시, 카메라 및 기타 객체를 애니메이션하는 방법을 보여줍니다.|

**소스 코드 및 프로젝트 파일 찾기**

이러한 각 프로그램의 폴더는 \<yourFBXSDKpath>\samples\UI Examples에 있습니다. 각 폴더에는 튜토리얼 프로그램의 소스 코드와 프로그램을 빌드하고 실행하는 데 도움이 되는 Visual Studio 프로젝트 파일이 포함되어 있습니다.

**모든 튜토리얼 프로그램에서 사용되는 공통 코드**

\<yourFBXSDKpath>\samples\UI Examples\Common 폴더에는 튜토리얼 프로그램에서 사용되는 공통 코드가 포함되어 있습니다.

**이 섹션의 페이지**

- Tutorial: ImportExport
- Tutorial: SceneTreeView
- Tutorial: CubeCreator

---

**Tutorial: ImportExport**

ImportExport 튜토리얼 프로그램은 파일을 한 파일 형식(FBX 바이너리, FBX ASCII, DAE 등)에서 다른 형식으로 변환하는 방법을 보여줍니다. 자세한 내용은 씬 가져오기 및 내보내기를 참조하십시오.

작업에는 다음이 포함됩니다:

- Visual Studio를 사용하여 샘플 프로그램을 빌드하고 실행합니다.
- SDK Manager로 메모리를 관리합니다.
- 빈 씬을 생성합니다.
- 파일 임포터를 생성합니다.
- 가져오기 파일을 씬에 로드합니다.
- 파일 익스포터를 생성합니다.
- 내보내기 파일의 파일 형식을 지정합니다.
- 미디어가 내보내기 파일에 포함되는지 여부를 지정합니다.
- 씬을 내보내기 파일로 내보냅니다.
- 정리 및 종료합니다.

**참고:** Windows에서만 빌드 및 실행됩니다.

**프로젝트 구성**

ImportExport 프로젝트는 `\<yourFBXSDKpath>\examples\UI Examples\importexport\`에 있습니다.

ImportExport에는 두 개의 소스 파일이 있습니다:

|소스 파일|설명|
|---|---|
|ImportExport.cpp|파일을 FBX가 지원하는 한 파일 형식에서 다른 형식으로 변환하는 플랫폼 독립적인 함수. 주요 로직이 있는 함수는 `ImportExport()`입니다.|
|UI.cpp|`ImportExport()`에 대한 사용자 인터페이스. 사용자 인터페이스 코드는 FBX SDK를 다운로드한 플랫폼에 따라 다릅니다. 이 소스 파일은 살펴보지 않을 것입니다.|

**사용자 인터페이스**

ImportExport 튜토리얼 프로그램의 사용자 인터페이스. Execute 버튼 옆의 큰 텍스트 상자에 메시지가 나타납니다.

**주요 로직**

ImportExport의 `ImportExport()` 함수에는 파일 변환 프로그램의 주요 로직이 포함되어 있습니다. `ImportExport()`는 다음을 수행합니다:

- 호출 프로그램(즉, UI.cpp)으로부터 다음 매개변수를 받습니다:
    - 가져올 파일의 경로 및 이름;
    - 내보낼 파일의 이름 및 경로;
    - 내보낼 파일의 파일 형식.
- 다른 FBX 객체가 사용하는 메모리를 관리하기 위해 SDK 관리자 객체를 생성합니다.
- 가져오기 파일의 데이터를 보관할 씬 객체를 생성합니다.
- 파일을 씬에 로드하기 위한 임포터 객체를 생성합니다.
- 가져오기 파일에서 씬으로 데이터를 로드합니다.
- 씬에서 내보내기 파일로 데이터를 저장합니다.
- SDK 관리자를 소멸시켜 모든 FBX 객체가 소멸되도록, 즉 SDK가 사용한 모든 메모리가 해제되도록 합니다.
- 호출 프로그램으로 제어를 반환합니다.

---

**Tutorial: SceneTreeView**

FBX 씬의 모든 노드를 순회하는 방법과 각 노드의 내용을 결정하는 방법, 즉 노드에 카메라, 조명, 메시 등이 포함되어 있는지 확인하는 방법을 보여줍니다. 자세한 내용은 __노드 및 씬 그래프__를 참조하십시오.

작업에는 다음이 포함됩니다:

- 씬의 루트 노드에 대한 참조를 가져옵니다.
- 각 자식 노드에 대한 참조를 가져옵니다.
- 양방향 관계의 양쪽 방향으로 참조를 가져옵니다.
- 노드의 속성을 공간의 한 점으로 가져옵니다.
- 노드의 속성 타입과 내용을 가져옵니다.

**참고:** Windows에서만 빌드 및 실행됩니다.

**프로젝트 구성**

SceneTreeView 프로젝트는 `\<yourFBXSDKpath>\examples\UI Examples\SceneTreeView\`에 있습니다.

SceneTreeView에는 두 개의 소스 파일이 있습니다:

|소스 파일|설명|
|---|---|
|SDK_Utility.cxx|FBX SDK를 호출하여 씬을 생성하고, 파일을 가져오고, 씬 그래프의 각 노드에서 데이터를 검색하고, 큐브에 머티리얼, 텍스처 및 애니메이션을 추가하는 플랫폼 독립적인 코드를 포함합니다. 이 튜토리얼은 이 파일의 코드 대부분을 설명합니다.|
|UI.cxx|사용자 및 Windows와 상호 작용하고, 씬 그래프를 순회하여 씬의 트리 뷰를 표시하는 코드를 포함합니다. 이 코드에는 FBX SDK에 대한 일부 호출이 포함되어 있습니다.|

**사용자 인터페이스**

SceneTreeView 샘플 프로그램은 FBX 파일을 빈 씬으로 가져온 다음 씬 그래프를 표시합니다. 씬 그래프는 더 정확하게는 트리이며, 노드 계층 구조라고도 합니다.

트리의 노드는 FBX 파일에서 가져온 씬 요소—카메라, 조명, 메시, 스켈레톤, NURBS 등—를 참조합니다. 이 트리를 표시하기 위해 SceneTreeView는 전체 트리를 순회해야 합니다. 즉, 각 노드를 방문해야 합니다.

**주요 로직**

SceneTreeView 로직:

- 사용자 인터페이스로부터 가져올 파일의 이름과 경로를 받습니다.
- 가져오기 파일을 씬에 로드합니다.
- 씬의 루트 노드에 대한 참조를 가져옵니다.

루트 노드부터 시작하여 SceneTreeView는 트리를 재귀적으로 순회합니다. 각 노드에서 SceneTreeView는:

- 노드의 이름과 속성 타입을 표시합니다.
- 노드 속성에 저장된 속성을 포함하여 노드의 선택된 속성을 표시합니다.
- 해당 노드의 각 자식에 대한 참조를 가져옵니다.

---

**Tutorial: CubeCreator**

이 튜토리얼 프로그램은 모델(이 경우 큐브)을 나타내는 메시에 텍스처, 머티리얼 및 애니메이션을 추가하는 방법을 보여줍니다. 작업에는 다음이 포함됩니다:

|상위 수준 작업|하위 수준 작업|
|---|---|
|기준 씬 구성|- 애니메이션을 포함할 애니메이션 스택 및 애니메이션 레이어 정의\<br>- 카메라에 애니메이션 추가\<br>- 초기 씬 그래프 구성|

**참고:** Windows에서만 빌드 및 실행됩니다.

**프로젝트 구성**

CubeCreator 프로젝트는 `\<yourFBXSDKpath>\examples\UI Examples\CubeCreator\`에 있습니다.

CubeCreator에는 두 개의 소스 파일이 있습니다:

|소스 파일|설명|
|---|---|
|SDK_Utility.cxx|FBX SDK를 호출하여 씬을 생성하고, 큐브를 추가하고, 큐브에 머티리얼, 텍스처 및 애니메이션을 추가하는 모든 코드를 포함합니다.\<br>이 튜토리얼은 이 파일의 코드 대부분을 설명합니다.|
|UI.cxx|씬의 트리 뷰를 표시하고 사용자와 상호 작용하는 코드를 포함합니다. 이 코드는 FBX SDK를 사용하여 UI가 트리 뷰에 표시하는 씬 데이터를 검색합니다.\<br>이 튜토리얼은 이 파일의 코드를 설명하지 않습니다.|

**사용자 인터페이스**

CubeCreator 샘플 프로그램은 씬의 모델에 텍스처, 머티리얼 및 애니메이션을 추가하는 방법을 보여줍니다.

시작 시 CubeCreator는 마커와 카메라만 포함된 씬의 트리 뷰를 표시합니다.

사용자는 씬에 큐브를 한 번에 하나씩 추가할 수 있습니다. 각 큐브에 대해 다음을 선택할 수 있습니다:

- 텍스처를 추가합니다.
- 머티리얼을 추가합니다.
- 애니메이션을 추가합니다.

씬을 FBX 파일(또는 FBX SDK에서 내보내는 모든 파일 형식)로 저장할 수 있습니다.

다음은 FBX for QuickTime에서 열었을 때 `8cubes.fbx`(위에 트리로 표시된 씬)의 모습입니다:

**런타임 시 텍스처 파일의 위치**

`\<yourFBXSDKpath>\examples\UI Examples\CubeCreator\`에는 CubeCreator가 텍스처 파일로 사용하는 `crate.jpg`라는 파일이 있습니다.

이 텍스처 파일을 CubeCreator의 실행 파일이 시작될 폴더에 복사해야 합니다. CubeCreator 프로젝트의 설정을 변경하지 않는 한:

- 빌드 시 `CubeCreator.exe`는 `\<yourFBXSDKpath>\bin\CubeCreator\`의 하위 디렉토리에 저장됩니다.
- 런타임 시 `CubeCreator.exe`는 동일한 디렉토리에서 실행됩니다. 해당 위치에서 텍스처 파일을 검색합니다.

FBX for QuickTime이 표면에 대한 텍스처 파일을 찾을 수 없으면 표면을 체커보드 패턴으로 렌더링합니다. 큐브의 면에 대한 모습은 다음과 같습니다:

**주요 로직**

CubeCreator는 다음 작업을 수행합니다:

- 마커, 카메라 및 조명이 포함된 기준 씬을 구성합니다.
- 카메라를 마커로 향하게 한 다음 카메라에 애니메이션을 추가합니다. 애니메이션은 항상 동일합니다: 뒤로 그리고 위로 쓸어 올리는 큐브의 뷰입니다.
- 사용자가 모든 큐브에 적용할 수 있는 하나의 머티리얼을 정의합니다.
- 모든 큐브에 적용할 수 있는 하나의 텍스처를 정의합니다.
- 모든 큐브에 적용할 수 있는 애니메이션을 정의합니다. 큐브에 적용하면 애니메이션으로 인해 큐브가 회전 축을 중심으로 회전합니다.
- 큐브를 한 번에 하나씩 추가할 수 있게 합니다. 큐브는 메시 객체입니다.
- 첫 번째 큐브를 마커 근처에 배치합니다.
- 후속 큐브를 번갈아 배치합니다: 가장 왼쪽 큐브의 왼쪽 및 위쪽, 그 다음 가장 오른쪽 큐브의 오른쪽 및 위쪽입니다.
- 각 큐브에 회전 축을 부여합니다: X, Y 또는 Z입니다.
- 사용자가 0~n개의 큐브를 추가할 수 있게 합니다. 추가된 각 큐브에 대해 머티리얼, 텍스처 및 애니메이션 중 일부 또는 전부를 추가할 수 있는 옵션이 있습니다. 씬을 FBX 파일(또는 FBX가 지원하는 다른 파일 형식)로 저장할 수 있게 합니다.
- 저장된 파일에 저장된 씬을 보고 상호 작용하기 위해 FBX for QuickTime을 사용하도록 초대합니다.

---

**샘플 프로그램 빌드 및 실행**

각 샘플은 FBX SDK 기능을 보여줍니다. 샘플 코드에는 기능을 설명하는 주석이 포함되어 있습니다.

**Visual Studio 프로젝트 / makefile 생성**

각 샘플 폴더에는 적절한 프로젝트/makefile을 생성하는 CMakeList.txt 규칙 파일이 포함되어 있습니다. 자세한 단계는 samples\README.txt에서 찾을 수 있습니다.

**Windows**

Visual Studio를 사용하여 샘플을 빌드하고 실행하려면:

1. Visual Studio를 시작합니다.
2. 파일 > 열기 > 프로젝트/솔루션을 클릭합니다.
3. Visual Studio 버전에 대한 샘플 프로그램이 포함된 폴더로 이동합니다. 예를 들어, C:\Program Files\Autodesk\FBX\FBX SDK\<version>\samples\UI Examples\ImportExport\입니다.
4. Visual Studio 버전에 대한 프로젝트 파일을 엽니다. Visual Studio는 새 솔루션을 만들고 해당 솔루션 내에서 프로젝트를 엽니다.
5. 파일을 빌드하려면 빌드 > 솔루션 빌드를 클릭합니다. 프로젝트를 수정하지 않는 한, Visual Studio는 프로젝트의 `Debug\\` 디렉토리에 저장된 애플리케이션의 디버그 버전(`ImportExport.exe`)을 빌드합니다.
6. Visual Studio 내에서 샘플을 실행하려면 디버그 메뉴에서 디버깅 시작을 선택합니다. ImportExport를 실행하면 ImportExport의 대화 상자가 나타납니다. 이를 사용하여 다양한 파일 형식으로 변환할 파일을 선택할 수 있습니다.

**Mac OS 및 Linux**

Mac OS 및 Linux 플랫폼에서 샘플 프로그램을 빌드하려면 생성된 makefile을 사용하십시오.

---

_중략 : Importing and Exporting a scene_

---

**FBX SDK 객체 모델**

이 섹션은 FBX SDK 객체 모델을 제시합니다. FBX SDK를 효과적으로 사용하는 방법에 대한 직관을 제공하기 위해 여러 핵심 개념이 여기에서 설명됩니다.

**메모리 관리**

FBX SDK 내의 메모리 관리는 FBX SDK Manager 객체(`FbxManager`)에 의해 수행됩니다. `FbxManager` 싱글톤은 SDK에서 사용하는 객체를 생성, 조작 및 소멸시키는 책임이 있습니다. 자세한 내용은 __FBX SDK Manager로 메모리 관리하기__를 참조하십시오.

**객체**

FBX SDK의 대부분의 클래스는 `FbxObject`에서 파생됩니다. 자세한 내용은 **FBX 객체** 주제와 `FbxObject` 클래스 레퍼런스 페이지를 참조하십시오. `FbxObject`에서 파생된 클래스의 예로는 씬 노드, I/O 객체 및 컬렉션이 있습니다.

**노드**

FBX 씬 그래프는 `FbxNode` 객체의 트리로 구성됩니다. 이러한 노드에는 카메라, 메시, NURBS, 조명 및 기타 모든 씬 요소가 연결됩니다. 이러한 씬 요소는 `FbxNodeAttribute`의 특수화된 인스턴스입니다. 자세한 내용은 __노드 및 씬 그래프__를 참조하십시오.

**IO 객체**

`FbxImporter` 및 `FbxExporter` 객체는 FBX SDK에서 씬을 가져오고 내보내는 데 사용됩니다. 자세한 내용은 **씬 가져오기 및 내보내기** 섹션과 `FbxIO`, `FbxImporter` 및 `FbxExporter`의 클래스 레퍼런스 페이지를 참조하십시오.

**컬렉션**

대부분의 컨테이너 클래스는 `FbxCollection` 클래스에서 파생되며, 멤버 함수에는 `FbxCollection::AddMember()`, `FbxCollection::RemoveMember()`, `FbxCollection::FindMember()`, `FbxCollection::IsMember()`, `FbxCollection::SetSelected()` 등이 포함됩니다.

**객체 속성**

`FbxNode`와 같은 FBX 객체는 기존의 C++ 멤버 변수 대신 FBX 속성(`FbxProperty`)을 사용합니다. FBX 속성을 사용하면 강력한 형식의 데이터를 FBX 객체에 동적으로 추가할 수 있습니다. 자세한 내용은 __FBX 속성__을 참조하십시오.

**연결**

연결 개념은 FBX SDK의 객체 모델을 이해하는 데 중요합니다. 연결은 객체를 서로, 속성을 서로, 객체를 속성에, 그리고 그 반대로 바인딩할 수 있습니다. API에서 사용 가능한 `Connection` 클래스는 없습니다. 대신, 연결은 `FbxObject::GetSrcObject()`와 같은 `FbxObject` 및 `FbxProperty`의 연결 관련 멤버 함수로만 조작할 수 있습니다. 자세한 내용은 __연결__을 참조하십시오.

---

**FBX SDK 관리자로 메모리 관리하기**

**FBX SDK 관리자 생성**

`FbxManager` 클래스는 FBX SDK 객체를 생성, 관리 및 소멸시키는 책임이 있습니다. 주어진 프로그램에는 하나의 `FbxManager` 인스턴스만 필요합니다. 이 `FbxManager` 싱글톤의 생성은 일반적으로 모든 FBX SDK 프로그램의 첫 번째 작업입니다.

```cpp
FbxManager* lSdkManager = FbxManager::Create();
```

**FBX SDK 관리자로 객체 생성**

FBX SDK의 객체는 각각의 `Create()` 및 `Destroy()` 멤버 함수를 통해 생성되거나 소멸됩니다. 하위 수준에서 이러한 함수는 `FbxManager`에 의존하여 메모리를 할당하고 해제합니다. 다음 예제에서 `FbxManager`는 새 씬을 인스턴스화하기 위해 `FbxScene::Create()` 함수에 매개변수로 전달됩니다.

```cpp
FbxScene* lScene = FbxScene::Create(lSdkManager, "Scene Name");
```

**메모리 할당**

SDK 객체 관리자(`FbxManager`)는 새 객체를 포함하기에 충분한 양의 메모리를 자동으로 할당합니다. 필수는 아니지만, 객체 관리자의 메모리 할당 전략은 `fbxalloc.h`에 있는 `FbxSetMallocHandler`와 같은 핸들러 설정 함수를 사용하여 사용자 정의할 수 있습니다. 사용자 정의 메모리 할당자를 사용하는 방법에 대한 정보는 ViewScene/main.cxx 예제를 참조하십시오.

**FBX 객체 명명**

위의 코드 스니펫에서 `FbxScene::Create()`의 두 번째 매개변수는 문자열입니다. 객체가 생성될 때, 문자열을 사용하여 새 객체의 이름을 지정할 수 있습니다. 이 문자열은 고유할 필요가 없으며, 빈 문자열 `""`을 전달하는 것도 허용됩니다. 객체 이름은 FBX SDK 애플리케이션과 그 출력의 디버깅을 용이하게 할 수 있습니다.

**참고:** FBX SDK의 현재 구현은 스레드 안전이 보장되지 않습니다. 동일한 `FbxManager`를 사용하여 생성되었지만 서로 다른 스레드에서 액세스되는 객체는 애플리케이션을 충돌시킬 가능성이 높습니다. 이것은 알려진 문제이며, 향후 릴리스에서 FBX SDK의 스레드 안전성을 보장할 계획이 있습니다.

**씬 내에서 객체 생성**

`FbxScene` 객체는 메시, 조명, 애니메이션, 캐릭터 등과 같은 다양한 씬 요소를 포함할 수 있습니다. 이러한 요소는 그것들이 존재하는 씬에 대한 참조와 함께 생성되어야 합니다. 따라서 씬이 내보내질 때 모든 요소도 함께 내보내집니다. 씬이 소멸되면 모든 객체에 할당된 메모리도 해제됩니다. ~~{ 노드 및 씬 그래프 }~~ 섹션은 씬 요소를 정의하고 조작하기 위한 `FbxNode` 및 `FbxNodeAttribute` 클래스의 사용을 설명합니다. 지금은 `FbxScene`이 이러한 객체를 생성하는 데 어떻게 사용될 수 있는지만 살펴보겠습니다.

```cpp
// 노드 객체 생성
FbxNode* lNode = FbxNode::Create(lScene, "node");
 
// 메시 객체 생성
FbxMesh* lMesh = FbxMesh::Create(lScene, "");
```

**참고:** `FbxScene` 대신 `FbxManager`에 대한 참조만 사용하여 씬 요소(`FbxNode`, `FbxNodeAttribute`)를 생성하는 것이 가능하지만, 씬이 소멸될 때 해당 씬 요소는 함께 소멸되지 않습니다. 명시적으로 소멸시키거나 `FbxManager`가 소멸될 때만 소멸됩니다.

**객체 소멸**

FBX SDK 객체는 `Destroy()` 멤버 함수를 호출하여 명시적으로 소멸시켜야 합니다. `FbxManager`는 해당 객체에 할당된 메모리를 자동으로 해제하고, 해당 객체(`FbxObject`), 그 속성(`FbxProperty`) 및 다른 `FbxObject` 간의 모든 내부 연결을 업데이트하여 불일치를 제거합니다. FBX SDK의 연결 개념에 대한 자세한 내용은 ~~{ 연결 }~~을 참조하십시오. 다음 코드 스니펫은 위에서 인스턴스화한 객체를 소멸시키는 방법을 보여줍니다.

```cpp
// 이러한 객체 소멸
lMesh->Destroy();      // 메시 소멸
lNode->Destroy();      // 노드 소멸
lScene->Destroy();     // 씬과 그 객체들 소멸
lSDKManager->Destroy() // SDK Manager와 그것이 관리하는 나머지 객체들 소멸.
```

---

**FBX 객체**

**FBX 객체 생성 및 소멸**

FBX 객체는 `FbxObject` 또는 `FbxObject`에서 파생된 다른 클래스의 인스턴스입니다. 객체의 인스턴스는 애플리케이션의 `FbxManager` 싱글톤에 대한 참조 또는 `FbxScene` 객체에 대한 참조와 함께 해당 클래스의 `Create()` 함수를 호출하여 생성됩니다.

객체는 `Destroy()` 멤버 함수를 호출하거나, 객체를 생성하는 데 사용된 `FbxManager` 또는 `FbxScene` 객체에서 `Destroy()`를 호출하여 명시적으로 소멸시킬 수 있습니다. `FbxObject`를 인스턴스화하는 데 사용된 `FbxManager`는 `FbxObject::GetFbxManager()`를 호출하여 검색할 수 있습니다. 다음 코드 샘플에서 `FbxImporter`는 `FbxIO`에서 상속하고, `FbxIO`는 `FbxObject`에서 상속한다는 점에 유의하십시오.

```cpp
// pImporter가 FbxImporter의 인스턴스라고 가정합니다.
FbxManager* lSdkManager = pImporter->GetFbxManager();
```

객체 생성 및 소멸에 대한 자세한 내용은 __FBX SDK Manager로 메모리 관리하기__를 참조하십시오.

**속성**

FBX SDK는 `FbxProperty` 클래스를 사용하여 `FbxObject` 인스턴스에 대한 강력한 형식의 정적 및/또는 동적 속성 연결을 강제합니다. FBX SDK 속성 모델은 **FBX 속성** 주제에 설명되어 있습니다.

**컬렉션**

`FbxAnimLayer`, `FbxAnimStack` 및 `FbxScene`과 같은 컨테이너 클래스는 `FbxCollection` 클래스에서 상속합니다. 이 클래스는 다음에 대한 인터페이스를 제공합니다:

- 멤버 추가 - `FbxCollection::AddMember()`
- 멤버 제거 - `FbxCollection::RemoveMember()`
- 멤버 개수 세기 - `FbxCollection::GetMemberCount()`
- 멤버 가져오기 - `FbxCollection::GetMember()`
- 멤버 검색 - `FbxCollection::FindMember()`

`FbxCollection::GetMemberCount()` 및 `FbxCollection::GetMember()` 함수는 `FbxCriteria`를 받아들이도록 오버로드되어 있습니다. 자세한 내용은 `FbxCriteria` 클래스 레퍼런스 페이지를 참조하십시오.

**참고:** **연결** 주제는 객체 및 속성 계층 구조 간을 탐색하는 방법에 대한 추가 정보를 제공합니다.

**FBX 객체 복사**

FBX 객체는 `Copy()` 멤버 함수를 호출하여 복사할 수 있습니다. 할당 연산자(`operator=`)는 FBX 객체를 복사하는 데 사용할 수 없습니다. 이는 비공개 멤버 함수입니다. 다음 코드 샘플은 메시 객체를 복사하는 방법을 보여줍니다.

```cpp
// lScene이 유효한 씬 객체에 대한 포인터라고 가정합니다.
FbxMesh* lSourceMesh = FbxMesh::Create (lScene, "");
 
// lSourceMesh에 대한 제어점 등을 정의합니다.
 
// 이 메시는 덮어쓰여질 것입니다
FbxMesh* lTargetMesh = FbxMesh::Create (lScene, "");
 
// lSourceMesh의 데이터를 lTargetMesh로 복사합니다. 
// 소스 객체와 대상 객체는 동일한 클래스(이 경우 FbxMesh)의 인스턴스여야 합니다.
lTargetMesh->Copy(lSourceMesh);
```

**참고:** `FbxObject`를 복사하면 연결된 모든 `FbxProperty` 인스턴스와 그 값도 복사됩니다.

**참고:** `FbxObject`를 복사해도 객체 간 연결(예: 부모-자식 관계)은 복사되지 않습니다. 이러한 연결은 복사본에 명시적으로 설정해야 합니다. 자세한 내용은 __연결__을 참조하십시오.

---

**FBX 속성**

**속성 관리**

FbxProperty 템플릿 클래스는 FbxObject의 데이터가 강력한 형식을 갖도록 하는 데 사용됩니다. 예를 들어, FbxNode의 로컬 이동 벡터는 FbxDouble3에 대해 매개변수화된 FbxPropertyT를 사용하여 설명됩니다.

FbxObject가 생성되면 정적 내장 FbxProperty가 자동으로 초기화됩니다. 자신만의 FbxProperty를 생성하려면 FbxProperty::Create()를 호출하고 FbxObject 또는 다른 FbxProperty에 대한 참조를 전달해야 합니다.

다음 코드 샘플은 Animation 예제에서 가져온 것입니다. 이 샘플에서 FbxProperty::Create()의 첫 번째 매개변수는 FbxScene 객체입니다. 두 번째 매개변수는 속성의 데이터 타입입니다(데이터 타입의 전체 목록은 fbxdatatypes.h 헤더 파일에서 찾을 수 있습니다). 세 번째 매개변수는 속성에 할당된 이름입니다.

```cpp
FbxProperty p = FbxProperty::Create(pScene, DTDouble3, "Vector3Property");
FbxSet<FbxDouble3>(p, FbxDouble3(1.1, 2.2, 3.3);
```

FbxProperty가 생성된 이름은 FbxProperty::GetName()을 호출하여 액세스할 수 있습니다. 이 이름은 계층 구조 내에서 속성을 검색하는 데 사용할 수 있습니다([속성 계층 구조](속성 계층 구조) 참조).

FbxProperty의 인스턴스는 FbxProperty::Destroy()를 호출하여 소멸시킬 수 있습니다. FbxProperty의 계층 구조는 루트 속성에서 FbxProperty::DestroyRecursively()를 호출하여 소멸시킬 수 있습니다.

**속성 데이터**

FbxProperty의 인스턴스는 각각 FbxProperty::Set() 및 FbxProperty::Get()을 호출하여 설정하고 액세스할 수 있는 데이터를 포함합니다. 예를 들어, FbxDouble3의 벡터로 표현되는 FbxNode 기하학적 변환 데이터는 다음과 같은 방식으로 액세스할 수 있습니다:

```cpp
// ... FbxNode* lNode 초기화 ...
FbxDouble3 translation = lNode->LclTranslation.Get();
FbxDouble3 rotation = lNode->LclRotation.Get();
FbxDouble3 scaling = lNode->LclScaling.Get();
```

FbxPropertyT 내에 포함된 데이터는 속성의 데이터 타입에 유효한 값으로만 설정할 수 있습니다. 일부 암시적 변환이 지원됩니다. 예를 들어, double이 필요할 때 int를 제공할 수 있습니다.

**플래그**

속성은 FbxProperty::GetFlag() 및 FbxProperty::ModifyFlag()를 사용하여 조작할 수 있는 FbxPropertyFlags::eFbxPropertyFlags 세트도 포함합니다.

**연산자**

표준 비교 및 할당 연산자를 사용하여 속성을 서로 비교하고 할당할 수 있습니다(FbxProperty::operator==(), FbxProperty::operator!=(), FbxProperty::operator=()).

**사용자 정의 데이터**

FbxProperty 클래스는 런타임에 FbxObject에 동적으로 연결될 수 있는 사용자 정의 데이터를 포함할 수 있습니다. 이에 대한 예제는 UserProperties 예제에서 찾을 수 있습니다.

**속성 계층 구조**

속성은 계층 구조로 구성될 수 있습니다. FbxProperty는 FbxObject 또는 다른 FbxProperty에 연결될 수 있습니다. 속성의 바인딩된 FbxObject는 FbxProperty::GetFbxObject()를 호출하여 액세스할 수 있습니다. ExportScene05 예제는 속성 계층 구조의 구성을 보여줍니다.

**FBX 객체의 속성에 액세스하기**

FBX 객체는 FbxObject::FindProperty()를 사용하여 검색할 수 있는 많은 속성을 가질 수 있습니다. 객체의 속성은 FbxObject::GetFirstProperty() 및 FbxObject::GetNextProperty()와 같은 메서드를 호출하여 반복할 수도 있습니다.

**참고:** FbxIOSettings의 클래스 문서는 속성 계층 구조의 구성에 대한 유용한 통찰력을 제공합니다.

**속성 계층 구조 탐색**

FBX 속성의 계층 구조는 FBX 속성 탐색 함수를 통해 순회할 수 있습니다: FbxProperty::GetParent(), FbxProperty::GetChild(), FbxProperty::GetSibling(), FbxProperty::Find() 등이 있습니다.

**참고:** 연결 주제는 객체 및 속성 계층 구조 간을 탐색하는 방법에 대한 추가 정보를 제공합니다.

**샘플 코드**

다음 샘플 코드는 ExportScene05 예제에서 가져온 것입니다. 자신만의 FbxProperty 값을 생성하고 FbxObjectMetaData 인스턴스(FbxObject에서 상속)에 바인딩하는 방법을 보여줍니다.

```cpp
// ... pScene을 FbxScene*로 초기화 ...

// pScene에 FbxObjectMetaData* 객체를 생성합니다.
FbxObjectMetaData* lFamilyMetaData = FbxObjectMetaData::Create(pScene, "Family");

// 매개변수화된 데이터 타입(DTString, DTFloat, DTDouble)을 기반으로 
// 여러 FbxProperty 인스턴스를 생성하고 데이터를 할당합니다.
//
// 네 번째 매개변수는 선택적 레이블 문자열로, FbxProperty::GetLabel() 및 
// FbxProperty::SetLabel()을 사용하여 가져오고 수정할 수 있습니다. 
// 이 레이블은 프로그램의 주 메모리에만 존재하며, 속성이 내보내질 때 
// 파일로 내보내지지 않습니다.
//
// 이러한 속성들은 pFamilyMetaData 객체 내에 포함될 것입니다.
//
FbxProperty::Create(lFamilyMetaData, DTString, "Level", "Level").Set(FbxString("Family")); // String
FbxProperty::Create(lFamilyMetaData, DTString, "Type", "Type").Set(FbxString("Wall"));     // String
FbxProperty::Create(lFamilyMetaData, DTFloat, "Width", "Width").Set(10.0f);              // float
FbxProperty::Create(lFamilyMetaData, DTDouble, "Weight", "Weight").Set(25.0);            // double
FbxProperty::Create(lFamilyMetaData, DTDouble, "Cost", "Cost").Set(1.25);                // double
```

---

**연결**

**연결 시각화**

연결은 FBX 객체 및/또는 FBX 속성 간의 양방향 관계를 관리하는 FBX SDK 데이터 구조입니다. FBX SDK 내에서 연결의 일관성을 보장하기 위해 실제 데이터 구조는 공개적으로 노출되지 않습니다. 대신, 연결은 FbxObject::ConnectSrcObject(), FbxObject::ConnectDstObject(), FbxProperty::ConnectDstObject(), FbxProperty::ConnectSrcProperty() 등과 같은 FbxObject 및 FbxProperty 연결 관리 메서드를 사용하여 조작할 수 있습니다.

연결은 FBX 객체 및 속성의 대상(destination) 및 소스(source) 계층 구조로 시각화할 수 있습니다.

- **객체-속성 연결**: 속성은 객체 내에 소스로 포함됩니다. FbxObject::GetSrcProperty()를 호출하면 주어진 인덱스에서 객체의 소스 속성을 반환합니다. 대칭적으로, FbxProperty::GetDstObject()를 호출하면 속성의 대상 객체를 반환합니다.
- **객체-객체 연결**: 객체 간의 부모-자식 관계는 연결을 사용합니다(예: 씬의 노드 계층 구조). 일반적으로 객체의 자식은 소스이며, FbxObject::GetSrcObject()를 사용하여 액세스합니다. 객체의 부모는 대상이며, FbxObject::GetDstObject()를 사용하여 액세스합니다.
- **속성-속성 연결**: 속성 간의 부모-자식 관계도 연결을 사용합니다(예: FbxIOSettings의 속성 계층 구조). 일반적으로 속성의 자식은 소스이며, FbxProperty::GetSrcProperty()를 사용하여 액세스합니다. 속성의 부모는 대상이라고 하며, FbxProperty::GetDstProperty()를 사용하여 액세스합니다.

위 다이어그램의 대상 및 소스 연결은 다음 코드 샘플에 설명되어 있습니다.

**obj0의 소스 객체에 액세스:**

```cpp
// ... obj0가 위 다이어그램을 반영하도록 초기화되었다고 가정합니다...
// 설명 목적으로 obj0에 연결된 소스 객체의 수를 셉니다.
int numSrcObjects = obj0->GetSrcObjectCount(); // numSrcObjects = 2

// obj0에 연결된 두 개의 소스 객체에 액세스합니다
// obj0->GetSrcObject(0)는 obj0->GetSrcObject()를 호출하는 것과 동일합니다
FbxObject* obj1 = obj0->GetSrcObject(0);
FbxObject* obj2 = obj0->GetSrcObject(1);
```

**obj0의 소스 속성에 액세스:**

```cpp
// ... obj0가 위 다이어그램을 반영하도록 초기화되었다고 가정합니다...
FbxProperty* prop0 = obj0->GetSrcProperty();
```

**obj1의 대상 객체에 액세스:**

```cpp
// ... obj1이 위 다이어그램을 반영하도록 초기화되었다고 가정합니다...
FbxObject* obj0 = obj1->GetDstObject();
```

**obj2에서 시작하여 임시적인 방식으로 계층 구조 순회:**

```cpp
// ... obj2가 위 다이어그램을 반영하도록 초기화되었다고 가정합니다...
// obj2를 사용하여 prop2에 액세스합니다.
FbxProperty* prop2 = obj2->GetSrcProperty();

// 설명 목적으로 prop2의 소스 속성 수를 셉니다.
int numSrcProperties = prop2->GetSrcPropertyCount(); // numSrcProperties = 2

// prop2에 대해 각각 0과 1로 인덱싱된 소스인 prop3과 prop4에 액세스합니다.
FbxProperty* prop3 = prop2->GetSrcProperty(0);
FbxProperty* prop4 = prop2->GetSrcProperty(1);

// obj2를 사용하여 obj0에 액세스합니다.
FbxObject* obj0 = obj2->GetDstObject();

// obj0를 사용하여 prop0에 액세스합니다.
FbxProperty* prop0 = obj0->GetSrcProperty();

// obj0를 사용하여 obj1에 액세스합니다.
// 여기서는 obj1이 0으로 인덱싱되고 obj2가 1로 인덱싱된다고 가정합니다.
FbxObject* obj1 = obj0->GetSrcObject(0);

// obj1을 사용하여 prop1에 액세스합니다.
FbxProperty* prop1 = obj1->GetSrcProperty();
```

**객체 및 속성 연결**

FBX SDK의 연결 개념은 FbxProperty의 인스턴스를 FbxObject에 동적으로 추가할 수 있도록 합니다. 이를 통해 자신만의 데이터 타입을 정의하고, FbxProperty::SetUserDataPtr() 멤버 함수를 통해 FBX 속성으로 래핑하고, FbxObject::ConnectSrcProperty() 멤버 함수를 통해 해당 속성을 FBX 객체에 바인딩하는 유연성을 제공합니다.

FbxCollection 클래스도 연결을 사용하여 객체 그룹을 계층 구조로 구성합니다. 예를 들어, FbxScene 클래스는 FbxScene::GetRootNode()를 통해 액세스할 수 있는 FbxNode 객체의 계층 구조를 포함합니다.

노드(FbxNode) 및 노드 속성(FbxNodeAttribute)과 관련된 연결의 사용에 대해 자세히 알아보기 전에 FBX SDK의 씬 그래프 구성에 익숙해지는 것이 좋습니다. 자세한 내용은 { 노드 및 씬 그래프 } 섹션을 참조하십시오. 그러나 모험심이 있다면, 아래에 설명된 개념이 노드와 그 속성을 사용하여 씬 그래프가 어떻게 구조화되는지에 대한 직관을 제공할 것입니다.

간단히 소개하면, FbxScene의 FbxNode 계층 구조는 기하학적 변환 스택을 지정하는 데 사용됩니다. FbxNodeAttribute에서 상속하는 클래스, 예를 들어 FbxMesh, FbxCamera 및 FbxLight는 씬의 모든 요소를 설명합니다. FbxNodeAttribute는 FbxNode에 연결되어 메시, 카메라 또는 조명이 3D 공간에서 어디에 존재하는지 지정합니다.

**"객체-객체" 연결 예제: 씬의 노드 간 부모-자식 관계**

씬의 노드 간 부모-자식 관계는 객체 연결을 사용합니다. 메서드가 호출된 부모 노드에 자식 노드를 추가하는 FbxNode::AddChild() 메서드를 고려하십시오:

```cpp
// ... lScene이 FbxScene*로 초기화되었다고 가정합니다,

// 씬의 루트 노드를 가져옵니다.
FbxNode* lParentNode = lScene->GetRootNode();

// 자식 노드를 생성합니다.
FbxNode* lChildNode = FbxNode::Create(lScene, "child");

// 자식 노드를 루트 노드에 추가합니다.
lParentNode->AddChild(lChildNode);
```

다음 연결이 만들어집니다:

- 자식 노드는 부모 노드의 소스 객체가 됩니다.
- 부모 노드는 자식 노드의 대상 객체가 됩니다.

**참고:** lParentNode는 lScene의 소스 객체입니다. 따라서 lScene은 lParentNode의 대상 객체입니다.

**참고:** { 두 씬 병합 } 주제는 두 씬의 내용을 병합하기 위해 노드 간의 연결을 명시적으로 조작합니다.

**"객체-객체" 연결 예제: 노드 및 노드 속성**

FbxNode와 FbxNodeAttribute의 관계는 일반적으로 FbxNode::SetNodeAttribute()를 호출하여 생성됩니다. 따라서 FbxMesh의 인스턴스(FbxNodeAttribute에서 상속)를 씬의 노드에 바인딩할 수 있습니다. 이 경우:

- FbxNodeAttribute는 FbxNode의 소스 객체입니다.
- FbxNode는 FbxNodeAttribute의 대상 객체입니다.

**참고:** 머티리얼(FbxSurfaceMaterial)도 FbxNode에 소스 객체로 연결됩니다. 하나의 노드는 많은 머티리얼에 연결될 수 있고, 하나의 머티리얼은 많은 노드에 연결될 수 있습니다(메모리 사용량을 줄이기 위해). 그러나 FbxSurfaceMaterial은 FbxNodeAttribute의 하위 클래스가 아닙니다.

**"객체-속성" 연결 예제: 노드 및 변환**

{ FBX 속성 } 하위 섹션에서 언급했듯이, FbxNode의 로컬 변환 데이터는 FbxDouble3 데이터 타입으로 매개변수화된 FbxPropertyT로 정의됩니다. 이 경우:

- FbxNode::LclTranslation에 의해 반환된 FbxPropertyT는 해당 FbxNode의 소스 속성입니다.
- FbxNode는 해당 FbxPropertyT의 대상 객체입니다.

---

**오류 처리**

**오류**

FBX 클래스의 많은 멤버 함수가 오류를 트리거할 수 있습니다. 그러한 경우:

- 함수는 `false`를 반환합니다.
- `*objectname*->GetStatus().GetErrorString()`은 오류 메시지가 포함된 문자열을 반환합니다.
- `*objectname*->GetStatus().GetCode()`는 열거형에 지정된 대로 발생한 오류 유형을 검색합니다.

**오류 처리 샘플**

다음 코드는 `Common/Common.cxx`에 나타납니다. 비밀번호 보호를 포함한 파일 가져오기 작업의 오류 처리 절차를 보여줍니다. 일부 코드는 오류 처리 기능을 강조하기 위해 "`// ...`"로 대체되었습니다.

```cpp
bool LoadScene(FbxManager* pManager, FbxDocument* pScene, const char* pFilename)
{
  //…

  bool lStatus;
  char lPassword[1024];

  //…

  // 임포터를 생성합니다.
  FbxImporter* lImporter = FbxImporter::Create(pManager,"");

  // 파일명을 제공하여 임포터를 초기화합니다.
  const bool lImportStatus = lImporter->Initialize(pFilename, -1, pManager->GetIOSettings());

  // …

  if(!lImportStatus)
    {
        FbxString error = lImporter->GetStatus().GetErrorString();
        FBXSDK_printf("Call to FbxImporter::Initialize() failed.\n");
        FBXSDK_printf("Error returned: %s\n\n", error.Buffer());

        if (lImporter->GetStatus().GetCode() == FbxStatus::eInvalidFileVersion)
        {
          FBXSDK_printf("FBX file format version for this FBX SDK is %d.%d.%d\n", lSDKMajor, lSDKMinor, lSDKRevision);
          FBXSDK_printf("FBX file format version for file '%s' is %d.%d.%d\n\n", pFilename, lFileMajor, lFileMinor, lFileRevision);
        }

        return false;
    }
    // …
    // 씬을 가져옵니다.

    lStatus = lImporter->Import(pScene);

    if(lStatus == false && lImporter->GetStatus().GetCode() == FbxStatus::ePasswordError)
    {
        FBXSDK_printf("Please enter password: ");
        lPassword[0] = '\0';

        FBXSDK_CRT_SECURE_NO_WARNING_BEGIN
        scanf("%s", lPassword);
        FBXSDK_CRT_SECURE_NO_WARNING_END

        FbxString lString(lPassword);

        IOS_REF.SetStringProp(IMP_FBX_PASSWORD, lString);
        IOS_REF.SetBoolProp(IMP_FBX_PASSWORD_ENABLE, true);

        lStatus = lImporter->Import(pScene);

        if(lStatus == false && lImporter->GetStatus().GetCode() == FbxStatus::ePasswordError)
        {
          FBXSDK_printf("\nPassword is wrong, import aborted.\n");
        }
    }

    if (!lStatus || (lImporter->GetStatus() != FbxStatus::eSuccess))
    {
        FBXSDK_printf("********************************************************************************\n");
        if (lStatus)
        {
            FBXSDK_printf("WARNING:\n");
            FBXSDK_printf("   The importer was able to read the file but with errors.\n");
            FBXSDK_printf("   Loaded scene may be incomplete.\n\n");
        }
        else
        {
            FBXSDK_printf("Importer failed to load the file!\n\n");
        }

        if (lImporter->GetStatus() != FbxStatus::eSuccess)
            FBXSDK_printf("   Last error message: %s\n", lImporter->GetStatus().GetErrorString());

        FbxArray<FbxString*> history;
        lImporter->GetStatus().GetErrorStringHistory(history);
        if (history.GetCount() > 1)
        {
            FBXSDK_printf("   Error history stack:\n");
            for (int i = 0; i < history.GetCount(); i++)
            {
                FBXSDK_printf("      %s\n", history[i]->Buffer());
            }
        }
        FbxArrayDelete<FbxString*>(history);
        FBXSDK_printf("********************************************************************************\n");
    }

    // 임포터를 소멸시킵니다.
    lImporter->Destroy();

    return lStatus;
}
```

---

**지원되는 문자열 형식**

FBX SDK는 내부적으로 UTF-8 문자열을 사용합니다. UTF-8(8비트 UCS/유니코드 변환 형식)은 유니코드를 위한 가변 길이 문자 인코딩입니다. 유니코드 표준의 모든 문자를 표현할 수 있으면서도 ASCII와 하위 호환됩니다. UTF-8에 대한 좋은 소개는 Wikipedia(wikipedia.com)를 참조하십시오.

FBX는 운영 체제의 API에서 함수를 호출할 때 UTF-8 문자열을 필요한 문자열 형식으로 변환합니다. 애플리케이션이 ASCII가 아닌 `char`를 사용하는 경우, FBX에 전달하기 전에 문자열을 UTF-8 `char *` C 문자열로 변환해야 합니다. fbxstring.h는 Windows 환경에 대해 다음 변환 함수를 정의합니다:

```cpp
FBXSDK_DLL void FbxWCToAnsi(const wchar_t* pInWideChar, char*& pOutANSI);
FBXSDK_DLL void FbxAnsiToWC(const char* pInANSI, wchar_t*& pOutWideChar);
FBXSDK_DLL void FbxAnsiToUTF8(const char* pInANSI, char*& pOutUTF8);
FBXSDK_DLL void FbxUTF8ToAnsi(const char* pInUTF8, char*& pOutANSI);
```

---

**FBX SDK 커스터마이징**

이 주제는 FBX SDK의 기능을 사용자 정의하거나 확장하는 방법을 제시합니다.

**사용자 정의 데이터**

`FbxObject` 및 `FbxProperty`의 인스턴스는 (`void*`) 포인터를 제공하므로 해당 인스턴스에 사용자 정의 데이터를 연결할 수 있습니다:

- `FbxObject` 사용자 데이터: `FbxObject::SetUserDataPtr()`, `FbxObject::GetUserDataPtr()`.
- `FbxProperty` 사용자 데이터: `FbxProperty::SetUserDataPtr()`, `FbxProperty::GetUserDataPtr()`.

**참고:** 사용자 정의 데이터를 생성, 소멸 및 기타 관리하는 책임은 사용자에게 있습니다.

**사용자 정의 속성**

`FbxProperty`의 사용자 정의 인스턴스는 `FbxObject`에 동적으로 추가될 수 있습니다. ~~{ FBX 속성 }~~에 제공된 샘플 코드는 이러한 사용자 정의 속성을 생성하고 추가하는 방법을 보여줍니다.

**ExportScene05**, **UserProperties** 및 **Tutorial: ImportExport** 샘플 프로그램도 사용자 정의 속성의 데이터를 가져오고 설정하는 방법에 대한 통찰력을 제공합니다.

**사용자 정의 클래스**

사용자 정의 클래스는 `FbxManager::RegisterFbxClass()`를 호출하여 `FbxManager`에 등록해야 합니다.

`<span class="char_link">[ExportScene03]()`/main.cxx에서 가져온 다음 샘플에서 사용자 정의 클래스 `MyFbxMesh` 및 `MyFbxObject`는 `ExportScene03/MyFbxMesh.h`에 정의되어 있습니다. 이러한 클래스는 각각 `FbxMesh` 및 `FbxObject`에서 상속합니다.

```cpp
#include <fbxsdk.h>
#include "../Common/Common.h"
#include "MyFbxMesh.h"

// ...

int main(int argc, char** argv)
{
    FbxManager* lSdkManager = NULL;
    FbxScene* lScene = NULL;
    // ...

    // FBX SDK를 준비합니다.
    InitializeSdkObjects(lSdkManager, lScene);

    // 생성한 새 클래스를 SDK Manager에 추가합니다
    // 우리 클래스 MyFbxMesh는 FbxMesh에서 파생되었습니다
    lSdkManager->RegisterFbxClass("MyFbxMesh", FBX_TYPE(MyFbxMesh), FBX_TYPE(FbxMesh));
    // 이제 클래스 MyFbxMesh를 사용할 준비가 되었습니다

    lSdkManager->RegisterFbxClass("MyFbxObject", FBX_TYPE(MyFbxObject), FBX_TYPE(FbxObject), "MyFbxObjectType", "MyFbxObjectSubType");
    // ...

}
```

**레이어 요소에 대한 사용자 정의 데이터**

사용자 정의 타입의 레이어 요소를 생성하려면 `FbxLayerElementUserData` 클래스를 사용하십시오. 다른 레이어 요소와 마찬가지로 폴리곤 정점별, 정점별, 폴리곤별 등으로 매핑할 수 있습니다.

__ExportScene03__의 `CreateCubeWithMaterialAndMyFbxMesh()` 함수를 참조하십시오. 이 함수는 float 및 boolean 데이터 타입을 기반으로 사용자 정의 복합체를 생성하고 각 정점에 대한 데이터를 추가합니다.

**사용자 정의 파일 형식**

FBX SDK는 여러 파일 형식을 사용하여 씬 데이터를 가져오고 내보냅니다. 이러한 각 파일 형식에는 자체 writer 클래스(`FbxWriter`에서 파생) 및 reader 클래스(`FbxReader`에서 파생)가 있습니다. 사용자 정의 `FbxWriter` 및 `FbxReader`를 사용하려면 FBX SDK I/O 플러그인을 통해 로드해야 합니다. 자세한 내용은 __FBX SDK I/O 플러그인으로 파일 형식 사용자 정의하기__를 참조하십시오.

**FBX Extensions SDK**

FBX Extensions SDK는 .dll 파일에 구현할 수 있는 콜백 함수 세트입니다. 이러한 함수는 3ds Max, Maya 및 MotionBuilder의 가져오기 및 내보내기 기능을 사용자 정의합니다. 자세한 내용은 __FBX Extensions SDK__를 참조하십시오.

---

**노드 및 씬 그래프**

이 섹션은 FBX 씬 그래프와 그 씬 요소 구성을 제시합니다.

**노드**

메시, 조명, 카메라, 스켈레톤 또는 선과 같은 씬 요소의 위치는 이동, 회전 및 스케일링 작업의 시퀀스로 설명할 수 있습니다. 이러한 기하학적 변환 데이터는 `FbxNode`에 의해 캡슐화됩니다.

**노드 속성**

씬의 카메라를 고려해보십시오. 이동, 회전 및 스케일링 값 외에도 프레임 너비, 프레임 높이, 피사계 심도, 모션 블러 등을 정의할 수도 있습니다. 이러한 추가 데이터는 `FbxNodeAttribute`의 하위 클래스인 `FbxCamera`에 의해 캡슐화됩니다. `FbxMesh` 및 `FbxLight`도 `FbxNodeAttribute`의 하위 클래스이며, 씬에서의 위치를 지정하기 위해 `FbxNode`에 바인딩될 수 있습니다.

---

**FBX 씬**

**씬 그래프 구성 요약**

FBX SDK 씬 그래프는 `FbxScene` 클래스에 의해 추상화됩니다. 씬은 노드(`FbxNode`)의 계층 구조로 구성됩니다. 씬의 루트 노드는 `FbxScene::GetRootNode()`를 통해 액세스됩니다. 메시, 조명 또는 카메라와 같은 씬 요소는 `FbxNode`를 `FbxNodeAttribute`의 하위 클래스와 결합하여 정의됩니다. 자세한 내용은 **FBX 노드** 및 __FBX 노드 속성__을 참조하십시오.

**참고:** 내보내기 작업 중에 씬의 루트 노드는 파일로 내보내지지 않습니다. 루트 노드의 자식만 파일로 내보내집니다. 따라서 파일에 저장되어야 하는 것을 루트 노드에 연결하는 것은 권장되지 않습니다.

**씬 생성**

__FBX SDK 관리자로 메모리 관리하기__에서 설명한 것처럼, `FbxScene`은 `FbxScene::Create()` 함수를 호출하여 생성됩니다. 새 `FbxScene`에는 루트 `FbxNode`와 기본 구성을 가진 `FbxGlobalSettings` 객체가 포함됩니다.

```cpp
// SDK 관리자를 생성합니다.
FbxManager* lSdkManager = FbxManager::Create();

// 씬을 생성합니다.
FbxScene* lScene = FbxScene::Create(lSdkManager, "Scene Name");
```

씬 요소는 그것들이 속한 `FbxScene`에 대한 참조를 사용하여 생성됩니다. 이렇게 함으로써 씬은 함께 생성된 모든 요소와 함께 내보내집니다. 다음 샘플에서는 노드가 `FbxScene`에 대한 참조와 함께 생성되고 씬의 루트 노드에 연결됩니다.

```cpp
// 씬의 루트 노드를 가져옵니다.
FbxNode* lRootNode = lScene->GetRootNode();

// 자식 노드를 생성합니다.
FbxNode* lChild = FbxNode::Create(lScene, "child");

// 자식을 루트 노드에 추가합니다.
lRootNode->AddChild(lChild);
```

**전역 씬 설정**

씬의 축 시스템, 시스템 단위, 주변 조명 및 시간 설정은 `FbxGlobalSettings` 객체에 정의됩니다. 이 객체는 `FbxScene::GetGlobalSettings()`를 통해 액세스됩니다.

**애니메이션 평가**

씬의 `FbxAnimEvaluator`는 특정 시간에 씬의 각 노드의 애니메이션된 기하학적 변환을 평가합니다. 또한 특정 머티리얼의 색상 변경과 같은 씬의 다른 애니메이션 가능한 속성도 평가합니다. 씬의 `FbxAnimEvaluator`는 `FbxScene::GetEvaluator()`를 통해 액세스됩니다. 자세한 내용은 __애니메이션__을 참조하십시오.

**텍스처 및 머티리얼 관리**

씬 내에서 생성된 머티리얼(`FbxSurfaceMaterial`) 및 텍스처(`FbxTexture`)는 `FbxScene::GetMaterial()` 및 `FbxScene::GetTexture()`와 같은 멤버 함수를 사용하여 액세스하고 수정할 수 있습니다. 메시와 함께 머티리얼 및 텍스처를 사용하는 방법에 대한 자세한 내용은 __메시, 머티리얼 및 텍스처__를 참조하십시오.

**캐릭터 및 캐릭터 포즈 관리**

씬 내의 캐릭터(`FbxCharacter`) 및 캐릭터 포즈(`FbxCharacterPose`)는 `FbxScene::GetCharacter()` 및 `FbxScene::GetCharacterPose()`를 사용하여 액세스할 수 있습니다. 씬에서 캐릭터를 정의하는 방법에 대한 자세한 내용은 `FbxCharacter` 및 `FbxCharacterPose`의 클래스 문서를 참조하십시오.

---

**두 씬 병합**

이 주제는 가져온 두 씬을 병합하는 방법을 제시합니다. 또한 씬과 그 안의 노드를 조작하는 기본적인 통찰력을 제공하며, 독자에게 연결 및 연결 관리 개념을 소개합니다.

두 씬을 병합하기 위한 단계는 다음과 같습니다:

1. 씬을 로드합니다.
2. 로드된 씬 내의 노드를 수정합니다.
3. 로드된 씬의 내용을 참조 씬으로 이동합니다.
4. 다른 씬을 로드합니다.
5. 참조 씬의 내용으로 새로 로드된 씬을 업데이트합니다.
6. 참조 씬을 소멸시킵니다.

**씬 로드 및 수정**

생성하는 첫 번째 객체는 FbxManager입니다. 이 단계는 후속 FBX SDK 객체를 생성하는 데 필요합니다. 그런 다음 "현재 씬"이라고 하는 새로 생성된 FbxScene 객체가 사용자 정의 LoadScene() 함수에 전달되어 "file1.fbx"(실행 프로그램과 같은 폴더에 있어야 함)의 가져온 내용으로 채워질 수 있습니다. 씬의 내용이 채워지면 루트 노드의 첫 번째 자식(인덱스 0)의 이름을 "Test Name"으로 변경하기만 하면 됩니다.

```cpp
// SDK 관리자를 생성합니다.
FbxManager* lSdkManager = FbxManager::Create();

// 가져온 파일로 채울 수 있도록 새 씬을 생성합니다.
FbxScene* lCurrentScene = FbxScene::Create(lSdkManager,"My Scene");

// 씬을 로드합니다.
LoadScene(lSdkManager, lCurrentScene, "file1.fbx");

// 씬을 수정합니다. 이 예제에서는 하나의 노드 이름만 변경됩니다.
lCurrentScene->GetRootNode()->GetChild(0)->SetName("Test Name");
```

**로드된 씬의 내용을 참조 씬으로 이동**

"참조 씬"이라고 하는 다른 FbxScene 객체가 생성됩니다. FbxScene 객체가 생성되면 루트 노드와 전역 설정도 함께 생성됩니다. 따라서 이 단계의 목표는 현재 씬의 루트 노드에서 자식을 제거하여 참조 씬의 루트 노드의 자식이 될 수 있도록 하는 것입니다.

```cpp
// 현재 로드된 씬의 내용을 저장할 참조 씬을 생성합니다.
FbxScene *lMyRefScene = FbxScene::Create(lSdkManager, "My Reference Scene");

// 현재 로드된 씬의 노드 트리를 참조 씬으로 이동합니다.
vector<FbxNode*> lChildren;
int lNumChildren = lCurrentScene->GetRootNode()->GetChildCount();
for(int i = 0; i < lNumChildren; i++) {

    // 현재 로드된 씬에서 자식 노드를 가져옵니다.
    lChildren.push_back(lCurrentScene->GetRootNode()->GetChild(i));

    // 자식 노드를 참조 씬의 루트 노드에 연결합니다.
   for( int c = 0; c < lChildren.size(); c )
       lMyRefScene->GetRootNode()->AddChild(lChildren[c]);
}

// 루트 노드에서 자식을 제거합니다.
lCurrentScene->GetRootNode()->DisconnectAllSrcObject();
```

현재 씬에 포함된 다른 FbxObject를 참조 씬으로 이동해야 할 수도 있습니다. 이러한 객체에는 FbxCharacter, FbxCharacterPose 및 FbxDocumentInfo의 인스턴스 등이 포함될 수 있습니다. 이러한 객체는 현재 씬의 루트 노드의 자식이 아니므로 다르게 이동해야 합니다. 이를 달성하기 위해 FBX SDK의 맥락에서 연결에 대한 기본 지식이 필요합니다.

연결은 두 FbxObject, FbxObject와 FbxProperty 또는 두 FbxProperty 간의 방향성 "소스에서 대상으로" 관계입니다. 연결에 대한 자세한 내용은 연결을 참조하십시오. 이 튜토리얼의 범위에서는 현재 씬에서 모든 관련 소스 객체의 연결을 끊고 참조 씬에 연결하려고 합니다. FbxObject::GetSrcObjectCount(), FbxObject::DisconnectAllSrcObject() 및 FbxObject::ConnectDstObject()를 사용하여 이를 수행합니다.

```cpp
// 다른 객체를 참조 씬으로 이동합니다.
int lNumSceneObjects = lCurrentScene->GetSrcObjectCount();
for(int i = 0; i < lNumSceneObjects; i++) {
    FbxObject* lObj = lCurrentScene->GetSrcObject(i);
    if(lObj == lCurrentScene->GetRootNode() || *lObj == lCurrentScene->GetGlobalSettings()){
        // 루트 노드나 씬의 전역 설정은 이동하지 않습니다. 
        // 이러한 객체는 모든 씬에 대해 생성됩니다.
        continue;
    }
    // 객체를 참조 씬에 연결합니다.
    lObj->ConnectDstObject(lMyRefScene);
}

// 모든 씬 객체의 연결을 끊습니다.
lCurrentScene->DisconnectAllSrcObject();
```

**참고:** 연결 개념을 사용하여 씬에서 특정 유형의 모든 객체를 가져올 수 있습니다. 다음 코드 스니펫에서는 lScene->GetSrcObjectCount(FbxMesh::ClassId)를 호출하여 씬에 연결된 메시를 반복합니다.

```cpp
for(int i = 0; i < lScene->GetSrcObjectCount(FbxMesh::ClassId); i++) {
    FbxMesh* lMesh = (FbxMesh*)lScene->GetSrcObject(FbxMesh::ClassId, i);
    //...
}
```

**다른 씬 로드 및 업데이트**

이 시점에서 현재 씬의 요소를 참조 씬으로 이동했으며 현재 씬은 비어 있게 되었습니다. 이제 현재 씬을 가져와 "file2.fbx"의 내용으로 다시 채웁니다. 마지막으로 현재 씬의 루트의 첫 번째 자식 이름을 참조 씬의 루트의 첫 번째 자식 이름으로 변경합니다. 결국 현재 씬의 루트의 첫 번째 자식 이름은 "Test Name"이 되어야 합니다.

```cpp
// 두 번째 파일을 lCurrentScene으로 가져옵니다.
LoadScene(lSdkManager, lCurrentScene, "file2.fbx");

// 두 번째 파일이 로드된 후 이름을 가져옵니다.
FbxString lNameBeforeUpdate = lCurrentScene->GetRootNode()->GetChild(0)->GetName();
FbxString lReferenceName = lMyRefScene->GetRootNode()->GetChild(0)->GetName();

// 루트의 자식 0 이름을 업데이트합니다.
lCurrentScene->GetRootNode()->GetChild(0)->SetName(lReferenceName);
FbxString lNameAfterUpdate = lCurrentScene->GetRootNode()->GetChild(0)->GetName();

// 참조 씬을 소멸시킵니다.
lMyRefScene->Destroy();
lMyRefScene = NULL;

// 검증 단계
printf("Verification (0 for success): %d\n", lNameAfterUpdate.Compare("Test Name"));
```

**씬 병합 튜토리얼 프로그램**

다음은 위에서 논의한 씬 병합 튜토리얼 프로그램입니다.

```cpp
#include <fbxsdk.h>

/**
 * FbxManager, FbxScene 및 유효한 파일명이 주어진 씬을 로드합니다.
 */
int LoadScene(FbxManager* pSdkManager, FbxScene* pScene, char* filename) {
    // io 설정 객체를 생성합니다.
    FbxIOSettings *ios = FbxIOSettings::Create(pSdkManager, IOSROOT);
    pSdkManager->SetIOSettings(ios);

    // sdk 관리자를 사용하여 임포터를 생성합니다.
    FbxImporter* lImporter = FbxImporter::Create(pSdkManager,"");

    // 첫 번째 인수를 임포터의 파일명으로 사용합니다.
    if(!lImporter->Initialize(filename, -1, pSdkManager->GetIOSettings())) {
        printf("Call to FbxImporter::Initialize() failed.\n");
        printf("Error returned: %s\n\n", lImporter->GetStatus().GetErrorString());
        lImporter->Destroy();
        return -1;
    }

    // 파일의 내용을 씬으로 가져옵니다.
    lImporter->Import(pScene);

    // 파일을 가져왔으므로 임포터를 제거할 수 있습니다.
    lImporter->Destroy();
    return 0;
}

/**
 * 두 씬 병합 샘플 프로그램의 진입점입니다.
 */
int main(int argc, char** argv) {
    // SDK 관리자를 생성합니다.
    FbxManager* lSdkManager = FbxManager::Create();

    // 가져온 파일로 채울 수 있도록 새 씬을 생성합니다.
    FbxScene* lCurrentScene = FbxScene::Create(lSdkManager,"My Scene");

    // 씬을 로드합니다.
    LoadScene(lSdkManager, lCurrentScene, "file1.fbx");

    // 씬을 수정합니다. 이 예제에서는 하나의 노드 이름만 변경됩니다.
    lCurrentScene->GetRootNode()->GetChild(0)->SetName("Test Name");

    // 현재 로드된 씬의 내용을 저장할 참조 씬을 생성합니다.
    FbxScene *lMyRefScene = FbxScene::Create(lSdkManager, "My Reference Scene");

    // 현재 로드된 씬의 노드 트리를 참조 씬으로 이동합니다.
    vector<FbxNode*> lChildren;
    int lNumChildren = lCurrentScene->GetRootNode()->GetChildCount();
    for(int i = 0; i < lNumChildren; i++) {

        // 현재 로드된 씬에서 자식 노드를 가져옵니다.
        lChildren.push_back(lCurrentScene->GetRootNode()->GetChild(i));

        // 자식 노드를 참조 씬의 루트 노드에 연결합니다.
        for( int c = 0; c < lChildren.size(); c )
           lMyRefScene->GetRootNode()->AddChild(lChildren[c]);
    }

    // 루트 노드에서 자식을 제거합니다.
    lCurrentScene->GetRootNode()->DisconnectAllSrcObject();

    // 다른 객체를 참조 씬으로 이동합니다.
    int lNumSceneObjects = lCurrentScene->GetSrcObjectCount();
    for(int i = 0; i < lNumSceneObjects; i++) {
        FbxObject* lObj = lCurrentScene->GetSrcObject(i);
        if(lObj == lCurrentScene->GetRootNode() || *lObj == lCurrentScene->GetGlobalSettings()){
            // 루트 노드나 씬의 전역 설정은 이동하지 않습니다.
            // 이러한 객체는 모든 씬에 대해 생성됩니다.
            continue;
        }
        // 객체를 참조 씬에 연결합니다.
        lObj->ConnectDstObject(lMyRefScene);
    }

    // 모든 씬 객체의 연결을 끊습니다.
    lCurrentScene->DisconnectAllSrcObject();

    // 두 번째 파일을 lCurrentScene으로 가져옵니다.
    LoadScene(lSdkManager, lCurrentScene, "file1.fbx");

    // 두 번째 파일이 로드된 후 이름을 가져옵니다.
    FbxString lNameBeforeUpdate = lCurrentScene->GetRootNode()->GetChild(0)->GetName();
    FbxString lReferenceName = lMyRefScene->GetRootNode()->GetChild(0)->GetName();

    // 루트의 자식 0 이름을 업데이트합니다.
    lCurrentScene->GetRootNode()->GetChild(0)->SetName(lReferenceName);
    FbxString lNameAfterUpdate = lCurrentScene->GetRootNode()->GetChild(0)->GetName();

    // 참조 씬을 소멸시킵니다.
    lMyRefScene->Destroy();
    lMyRefScene = NULL;

    // 검증 단계
    printf("Verification (0 for success): %d\n", lNameAfterUpdate.Compare("Test Name"));

    // sdk 관리자를 소멸시킵니다.
    lSdkManager->Destroy();
    exit(0);
}
```

---

**FBX 노드**

**노드란 무엇인가?**

노드는 주로 씬 내에서 씬 요소의 위치, 회전 및 스케일을 지정하는 데 사용됩니다. 노드는 FbxNode 클래스에 의해 추상화됩니다. FbxScene은 노드의 부모-자식 계층 구조를 포함합니다. 이 트리의 루트 노드는 FbxScene::GetRootNode()를 통해 액세스됩니다. { FBX 씬 }에 자세히 설명된 것처럼, 추가 노드를 생성하고 이 루트 노드에 추가할 수 있습니다.

```cpp
// 씬의 루트 노드를 가져옵니다.
FbxNode* lRootNode = lScene->GetRootNode();

// 자식 노드를 생성합니다.
FbxNode* lNode = FbxNode::Create(lScene, "child");

// 자식을 루트 노드에 추가합니다.
lRootNode->AddChild(lNode);
```

**참고:** 일부 파일 형식은 중복된 노드 이름을 허용하지 않습니다. 이 경우 중복된 이름은 nodename_ncl1, nodename_ncl2, nodename_ncl3 등으로 이름이 변경됩니다. 이전 FBX 파일 형식(버전 1.0에서 버전 6.1)은 중복된 노드 이름을 허용하지 않았습니다.

**노드 계층 구조**

노드 계층 구조는 FbxNode::GetChild() 및 FbxNode::GetParent()와 같은 메서드를 사용하여 순회됩니다. FbxNode::GetChildCount()는 해당 노드의 자식 수를 반환합니다.

노드는 노드의 위치, 회전 및 스케일이 부모의 좌표 시스템과 관련하여 설명되도록 계층 구조로 구성됩니다. 예를 들어, 아래 다이어그램에서 cubeNode가 rootNode의 x축을 따라 4단위만큼 이동하면 lightNode도 이 이동의 영향을 받습니다. 그러나 cameraNode는 cubeNode의 자식이 아니므로 이 이동의 영향을 받지 않습니다.

회전 및 스케일링 변환이 부모와 그 자식에 적용되는 순서는 노드의 상속 타입(ETransformInheritType)에 의해 지정됩니다. 이 변환 상속은 FbxNode::SetTransformationInheritType()을 사용하여 설정할 수 있습니다. 자세한 내용은 FbxNode 클래스 문서를 참조하십시오.

씬 내보내기 및 FBX 씬에서 언급했듯이, 씬의 루트 노드는 씬을 내보낼 때 저장되지 않습니다. 루트 노드의 재귀적으로 하위인 자식만 씬과 함께 내보내집니다. 위 다이어그램에서 rootNode가 씬의 루트 노드라고 가정합니다. 씬을 내보낼 때 rootNode는 저장되지 않습니다. 그러나 cubeNode, lightNode 및 cameraNode는 노드 속성과 함께 파일에 저장됩니다.

**노드 속성**

메시, 조명, 카메라 또는 씬에 있는 기타 객체는 일반적으로 FbxNodeAttribute의 하위 클래스, 예를 들어 FbxMesh, FbxLight 또는 FbxCamera에 의해 추상화됩니다. FbxNodeAttribute는 FbxNode에 바인딩되어 씬에서의 위치를 설명합니다. 이 바인딩은 FbxNode::SetNodeAttribute()를 사용하여 수행됩니다.

위 다이어그램에서 FbxNode* lightNode의 노드 속성은 FbxLight입니다. 따라서 씬에서 FbxLight* light의 위치는 FbxNode* rootNode에서 FbxNode* lightNode까지 각 노드에 적용된 누적 변환에 따라 달라집니다.

하나의 노드에 둘 이상의 노드 속성을 바인딩할 수 있습니다. 이 개념은 다양한 상세도(LOD)의 메시를 다룰 때 유용합니다. 마찬가지로 하나의 노드 속성을 여러 노드에 바인딩할 수 있습니다. 이 기술은 "인스턴싱"으로 알려져 있으며, 메모리 소비를 줄입니다. 자세한 내용은 인스턴싱 - 메시 공유를 참조하십시오.

**참고:** FbxSurfaceMaterial도 노드에 바인딩될 수 있으며, 예를 들어 메시의 표면 속성을 정의하기 위해 그 속성에 적용될 수 있습니다. FbxSurfaceMaterial은 FbxNodeAttribute의 하위 클래스가 아닙니다.

**변환 데이터**

노드의 변환 데이터에는 부모에 대한 이동, 회전 및 스케일링 벡터가 포함됩니다. 이 데이터는 FbxNode::LclTranslation, FbxNode::LclRotation, FbxNode::LclScaling을 통해 액세스할 수 있는 FbxPropertyT 객체 세트로 표현됩니다. "Lcl" 접두사는 "로컬"을 나타냅니다.

```cpp
FbxDouble3 translation = lNode->LclTranslation.Get();
FbxDouble3 rotation = lNode->LclRotation.Get();
FbxDouble3 scaling = lNode->LclScaling.Get();
```

노드의 변환 데이터는 FbxNode::GetTranslationLimits(), FbxNode::GetRotationLimits() 및 FbxNode::GetScalingLimits()를 통해 액세스할 수 있는 FbxLimits 객체에 의해 제한될 수 있습니다. 노드는 FbxConstraint 객체를 사용하여 제약할 수도 있습니다. 자세한 내용은 FbxLimits 및 FbxConstraint의 클래스 문서를 참조하십시오.

씬의 전역 좌표 시스템에 대한 노드의 이동, 회전 및 스케일링 속성은 변환 행렬로 표현될 수 있습니다. 이 변환 행렬은 FbxNode::EvaluateGlobalTransform()을 통해 얻습니다.

**노드 그룹화**

FbxNode의 인스턴스는 바인딩된 FbxNodeAttribute 없이 존재할 수 있습니다. 이 경우 이러한 FbxNode는 씬에서 자식 노드를 그룹화하거나 배치하는 데 사용할 수 있습니다.

---

**변환 행렬 계산**

FBX SDK와 Maya는 변환 행렬을 계산하기 위해 동일한 공식을 사용합니다. 그러나 3ds Max는 다른 공식을 사용합니다.

**참고:** 3ds Max용 FBX 임포터 및 익스포터는 변환 행렬을 3ds Max와 자동으로 변환합니다.

**FBX 및 Maya**

다음 공식은 FBX SDK와 Maya가 노드의 변환 행렬을 계산하는 방법을 나타냅니다:

`WorldTransform = ParentWorldTransform * T * Roff * Rp * Rpre * R * Rpost⁻¹ * Rp⁻¹ * Soff * Sp * S * Sp⁻¹`

주어진 벡터는 `V' = WorldTransform * V`가 되도록 변환됩니다.

|항목|포함하는 4 x 4 행렬:|
|---|---|
|`WorldTransform`|노드의 변환 행렬|
|`ParentWorldTransform`|부모 노드의 변환 행렬|
|`T`|이동|
|`Roff`|회전 오프셋|
|`Rp`|회전 피벗|
|`Rpre`|사전 회전|
|`R`|회전|
|`Rpost⁻¹`|사후 회전의 역행렬|
|`Rp⁻¹`|회전 피벗의 역행렬|
|`Soff`|스케일링 오프셋|
|`Sp`|스케일링 피벗|
|`S`|스케일링|
|`Sp⁻¹`|스케일링 피벗의 역행렬|

**참고:**

- 공식의 효과는 주어진 벡터가 먼저 스케일링되고, 그 다음 회전되고, 마지막으로 이동된다는 것입니다.
- `R` 행렬은 회전 순서를 고려합니다. 행렬의 수학적 속성 때문에 `R`은 `Rx`, `Ry` 및 `Rz`(각각 행렬)의 가능한 조합 중 하나의 결과입니다. 예를 들어, 기본 회전 순서인 XYZ의 경우 `R = Rz * Ry * Rx`입니다.

**3ds Max**

다음 공식은 3ds Max가 노드의 변환 행렬을 계산하는 방법을 나타냅니다. 공식의 모든 항은 기하학적 변환을 나타내는 세 항을 제외하고는 FBX 및 Maya와 동일합니다:

`WorldTransform = ParentWorldTransform * T * R * S * OT * OR * OS`

|항목|포함하는 4 x 4 행렬:|
|---|---|
|`WorldTransform`|노드의 변환 행렬|
|`ParentWorldTransform`|부모 노드의 변환 행렬|
|`T`|이동|
|`R`|회전|
|`S`|스케일링|
|`OT`|기하학적 변환 이동|
|`OR`|기하학적 변환 회전|
|`OS`|기하학적 변환 스케일링|

**참고:**

- 기하학적 이동, 기하학적 회전 및 기하학적 스케일링은 3ds Max의 객체 오프셋 개념과 관련이 있습니다. 이러한 기하학적 변환은 노드 변환 후 노드 속성에 적용됩니다.
- 기하학적 변환은 상속되지 않습니다: `ParentWorldTransform`에는 `WorldTransform`의 부모 노드의 OT, OR 및 OS가 포함되지 않습니다.
- 기하학적 변환은 FBX SDK에서 `FbxNode` 객체의 세 가지 속성으로 구현됩니다: `FbxNode::GeometricTranslation`, `FbxNode::GeometricRotation` 및 `FbxNode::GeometricScaling`.

---

**FBX 노드 속성**

**노드 속성 생성**

`FbxNodeAttribute`는 `FbxNode`와 쌍을 이루어 특정 위치, 회전 및 스케일을 가진 씬 요소를 정의합니다. 해당 노드에 노드 속성이 설정되지 않은 경우 `FbxNode::GetNodeAttribute()`를 호출하면 `NULL`을 반환합니다.

다음 코드 샘플(위의 다이어그램에 맞게 `ExportScene04/main.cxx`에서 조정됨)은 씬 내에서 간단한 스포트라이트를 생성하는 방법을 보여줍니다. 여기서 `FbxLight* light`는 `FbxNode* lightNode`의 노드 속성입니다. 조명에 대한 자세한 내용은 ~~{ 조명 }~~을 참조하십시오.

```cpp
// 스포트라이트를 생성합니다.
FbxNode* CreateLight(FbxScene* pScene, char* pName)
{
    FbxLight* light = FbxLight::Create(pScene,pName);

    light->LightType.Set(FbxLight::eSpot);
    light->CastLight.Set(true);

    FbxNode* lightNode = FbxNode::Create(pScene,pName);

    lightNode->SetNodeAttribute(light);

    return lightNode;
}
```

**노드 속성**

다음 표는 기본 씬 요소 세트와 관련된 `FbxNodeAttribute` 하위 클래스를 제시합니다. 이러한 노드 속성은 `FbxNode::SetNodeAttribute()`를 사용하여 `FbxNode`와 쌍을 이룰 수 있습니다. 전체 클래스 계층 구조는 C++ 레퍼런스 가이드를 참조하십시오.

|씬 요소|`FbxNodeAttribute` 하위 클래스|
|---|---|
|카메라|`FbxCamera`, `FbxCameraStereo`|
|카메라 전환기 (Autodesk MotionBuilder의 사용자 정의 카메라 정의)|`FbxCameraSwitcher`|
|조명|`FbxLight`|
|메시|`FbxMesh`|
|Nurb|`FbxNurbs`, `FbxNurbsCurve`, `FbxNurbsSurface`, `FbxTrimNurbsSurface`|
|패치 / 매개변수 표면|`FbxPatch`|
|상세도 그룹|`FbxLodGroup`|
|마커|`FbxMarker`|
|스켈레톤|`FbxSkeleton`|

**참고:** 일부 애플리케이션은 씬 그래프에 null 노드 타입이 필요합니다. `FbxNull` 노드 속성은 이러한 노드 타입을 정의하는 데 사용됩니다. `FbxNull`의 인스턴스는 `NULL` 값과 동일하지 않습니다.

**노드 속성 타입**

`FbxNodeAttribute`의 타입(`FbxNodeAttribute::EType`)은 `FbxNodeAttribute::GetAttributeType()`을 호출하여 얻을 수 있습니다. `EType`은 노드 속성 객체를 적절한 하위 클래스로 다운캐스팅하는 데 유용합니다.

다음 코드 샘플(`ImportScene/main.cxx` 및 `ImportScene/DisplayLight.cxx`에서 조정됨)은 switch를 사용하여 `FbxNode`에 포함된 `FbxLight`를 표시하는 방법을 보여줍니다.

```cpp
//
// ImportScene/DisplayLight.cxx에서 조정됨 ...
// FbxNode 내에 포함된 FbxLight의 다양한 속성을 표시합니다.
//
void DisplayLight(FbxNode* pNode)
{
    FbxLight* lLight = (FbxLight*) pNode->GetNodeAttribute();

    DisplayString("Light Name: ", (char *) pNode->GetName());
    // ...

    char* lLightTypes[] = { "Point", "Directional", "Spot" };

    DisplayString("    Type: ", lLightTypes[lLight->LightType.Get()]);
    DisplayBool("    Cast Light: ", lLight->CastLight.Get());

    if (!(lLight->FileName.Get().IsEmpty()))
    {
        DisplayString("    Gobo");

        DisplayString("        File Name: \"", lLight->FileName.Get().Buffer(), "\"");
        DisplayBool("        Ground Projection: ", lLight->DrawGroundProjection.Get());
        DisplayBool("        Volumetric Projection: ", lLight->DrawVolumetricLight.Get());
        DisplayBool("        Front Volumetric Projection: ", lLight->DrawFrontFacingVolumetricLight.Get());
    }

    // ...
}

//
// ImportScene/main.cxx에서 조정됨 ...
// 노드의 내용을 표시합니다. 여기서는 FbxLight 노드 속성과 일치하는
// eLight 속성 타입만 살펴보는 데 관심이 있습니다.
//
void DisplayContent(FbxNode* pNode)
{
    FbxNodeAttribute::EType lAttributeType;
    int i;

    if(pNode->GetNodeAttribute() == NULL)
    {
        printf("NULL Node Attribute\n\n");
    }
    else
    {
        lAttributeType = (pNode->GetNodeAttribute()->GetAttributeType());

        switch (lAttributeType)
        {
            // ...

        case FbxNodeAttribute::eLight:     
            DisplayLight(pNode);
            break;

            // ...
        }
    }

    // ...

    for(i = 0; i < pNode->GetChildCount(); i++)
    {
        DisplayContent(pNode->GetChild(i));
    }
}
```

---

**조명**

**조명 생성**

FBX SDK의 조명은 FbxLight 클래스에 의해 추상화됩니다. FbxLight는 씬의 다른 객체와 마찬가지로 생성됩니다.

기본적으로 FbxLight는 노드의 음의 Y축을 따라 향합니다.

```cpp
// 씬에서 조명을 위한 노드를 생성합니다.
FbxNode* lLightNode = FbxNode::Create(pScene, "lightNode");

// 조명을 생성합니다.
FbxLight* lLight = FbxLight::Create(pScene, "light");

// 조명 노드의 노드 속성을 설정합니다.
lLightNode->SetNodeAttribute(lLight);

// 조명 노드를 씬의 루트 노드에 추가합니다.
FbxNode* lRootNode = pScene->GetRootNode();
lRootNode->AddChild(lLightNode);
```

**참고:** 씬의 주변 조명은 FbxScene::GetGlobalSettings()를 통해 액세스할 수 있는 전역 설정에 정의됩니다. 자세한 내용은 FbxGlobalSettings 클래스 문서를 참조하십시오.

**조명 타입**

조명의 동작은 FbxLight::LightType 속성을 설정하여 정의할 수 있습니다.

```cpp
// 조명의 타입을 스포트라이트로 설정합니다.
lLight->LightType.Set(FbxLight::eSpot);
```

다음 표는 각 조명 타입의 동작을 요약합니다.

|조명 타입 (FbxLight::ELightType)|설명|
|---|---|
|FbxLight::eSpot|조명이 원점에서 스포트라이트처럼 원뿔 모양으로 퍼집니다.<br><br>FbxLight::InnerAngle 및 FbxLight::OuterAngle 속성이 원뿔의 매개변수를 도 단위로 결정합니다.|
|FbxLight::ePoint|조명이 원점에서 모든 방향으로 균일하게 퍼집니다.|
|FbxLight::eDirectional|조명이 원점에서 원통 모양으로 퍼집니다.|

**조명 방향 지정**

스포트라이트 또는 직접 조명은 씬의 특정 대상을 일관되게 향하도록 강제할 수 있습니다. 이를 위해 조명의 노드는 FbxNode::SetTarget()을 사용하여 대상을 설정해야 합니다. FbxMarker 노드 속성이 대상 노드에 사용됩니다.

```cpp
// 마커를 포함할 노드를 생성합니다. 이것이 대상 노드가 됩니다.
FbxNode* lTargetNode = FbxNode::Create(pScene, "targetNode");

// 마커 노드 속성을 생성합니다.
FbxMarker* lMarker = FbxMarker::Create(pScene, "lightMarker");

// 마커를 대상 노드의 속성으로 설정합니다.
lTargetNode->SetNodeAttribute(lMarker);

// 조명 노드의 대상을 설정합니다.
lLightNode->SetTarget(lTargetNode);
```

기본적으로 FbxNode는 양의 X축을 조준 제약 조건으로 사용합니다. 새로 생성된 조명은 기본적으로 노드의 음의 Y축을 따라 향한다는 것을 상기하십시오. 조명이 노드의 양의 X축을 따라 향하도록 하려면 FbxNode::SetPostTargetRotation()을 사용하여 조명 노드에 90도의 회전 오프셋을 적용해야 합니다. 자세한 내용은 FbxNode 클래스 문서의 "노드 대상 관리" 섹션을 참조하십시오.

**색상 및 강도**

조명의 색상은 FbxLight::Color 속성에 정의됩니다. 조명의 기본 RGB 값은 FbxDouble3로 표현되는 (1.0, 1.0, 1.0)입니다.

```cpp
// 조명의 색상을 (0, 1, 0.5)로 설정합니다.
lLight->Color.Set(FbxDouble3(0.0, 1.0, 0.5));
```

조명의 강도는 FbxLight::Intensity 속성에 정의됩니다. 강도의 기본 값은 FbxDouble1로 표현되는 100.0입니다.

```cpp
// 조명의 강도를 50.0으로 설정합니다.
lLight->Intensity.Set(50.0)
```

**조명 감쇠**

조명의 감쇠 타입은 FbxLight::DecayType 속성에 정의됩니다.

```cpp
// 조명의 감쇠 타입을 이차 감쇠로 설정합니다.
lLight->DecayType.Set(FbxLight::eQuadratic);
```

다음 표는 사용 가능한 감쇠 타입을 요약합니다.

|감쇠 타입 (FbxLight::EDecayType)|설명|
|---|---|
|FbxLight::eNone|감쇠 없음. 조명의 강도는 거리에 따라 감소하지 않습니다.|
|FbxLight::eLinear|선형 감쇠. 조명의 강도는 조명으로부터의 거리에 따라 선형적으로 감소합니다.|
|FbxLight::eQuadratic|이차 감쇠. 조명의 강도는 조명으로부터의 거리의 제곱에 따라 감소합니다. 이것은 물리적으로 가장 정확한 감쇠율입니다.|
|FbxLight::eCubic|삼차 감쇠. 조명의 강도는 조명으로부터의 거리의 세제곱에 따라 감소합니다.|

**참고:** FbxLight::EnableNearAttenuation 및 FbxLight::EnableFarAttenuation과 같은 다른 거리 기반 감쇠 속성도 사용할 수 있습니다. 자세한 내용은 FbxLight 클래스 문서를 참조하십시오.

**그림자**

그림자는 FbxLight::CastShadows 부울 속성을 사용하여 활성화됩니다. 조명 그림자의 색상은 FbxLight::ShadowColor 속성에 정의됩니다. 조명 그림자의 기본 RGB 값은 FbxDouble3로 표현되는 (0.0, 0.0, 0.0)입니다. FbxLight::SetShadowTexture()를 사용하여 그림자 텍스처를 적용할 수도 있습니다.

---

**카메라**

**카메라 생성**

FBX SDK의 카메라는 `FbxCamera` 클래스에 의해 추상화됩니다. 3D 이미징용 스테레오 카메라는 `FbxCameraStereo` 클래스에 의해 추상화됩니다. 이 주제에서는 `FbxCamera`를 생성하고 조작하는 기본적인 방법만 살펴보겠습니다.

기본적으로 `FbxCamera`는 노드의 양의 X축 방향을 향합니다.

```cpp
// 씬에서 카메라를 위한 노드를 생성합니다.
FbxNode* lCameraNode = FbxNode::Create(pScene, "cameraNode");

// 조명을 생성합니다.
FbxCamera* lCamera = FbxCamera::Create(pScene, "camera");

// 카메라 노드의 노드 속성을 설정합니다.
lCameraNode->SetNodeAttribute(lCamera);

// 카메라 노드를 씬의 루트 노드에 추가합니다.
FbxNode* lRootNode = pScene->GetRootNode();
lRootNode->AddChild(lCameraNode);
```

카메라가 생성되면 씬의 기본 카메라로 설정할 수 있습니다. 씬에 카메라가 하나만 있는 경우에도 씬의 기본 카메라를 명시적으로 설정해야 합니다.

```cpp
// 씬의 기본 카메라를 설정합니다.
pScene->GetGlobalSettings().SetDefaultCamera((char *) lCamera->GetName());
```

**카메라 방향 지정**

카메라는 씬의 특정 대상을 일관되게 향하도록 강제할 수 있습니다. 이를 위해 카메라의 노드는 `FbxNode::SetTarget()`을 사용하여 대상을 설정해야 합니다. `FbxMarker` 노드 속성이 대상 노드에 사용됩니다.

```cpp
// 마커를 포함할 노드를 생성합니다. 이것이 대상 노드가 됩니다.
FbxNode* lTargetNode = FbxNode::Create(pScene, "targetNode");

// 마커 노드 속성을 생성합니다.
FbxMarker* lMarker = FbxMarker::Create(pScene, "cameraMarker");

// 마커를 대상 노드의 속성으로 설정합니다.
lTargetNode->SetNodeAttribute(lMarker);

// 카메라 노드의 대상을 설정합니다.
lCameraNode->SetTarget(lTargetNode);
```

**참고:** 자세한 내용은 `FbxNode` 클래스 문서의 "노드 대상 관리" 섹션을 참조하십시오.

기본적으로 `FbxCamera::FocusSource` 속성은 카메라의 대상에 초점을 유지하기 위해 `FbxCamera::eFocusSrcCameraInterest`로 설정됩니다. 초점 소스는 카메라로부터 특정 거리로도 설정할 수 있습니다.

```cpp
// 카메라의 초점 소스를 특정 거리로 설정합니다.
lCamera->FocusSource.Set(FbxCamera::eFocusSpecificDistance);

// 카메라로부터 거리를 100.0 단위로 설정합니다.
// 이 거리의 기본 값은 200.0 단위입니다.
lCamera->FocusDistance.Set(100.0);
```

**카메라 속성**

씬에서 카메라를 구성하는 방법에 대한 자세한 내용은 `FbxCamera` 클래스 문서를 참조하십시오.

---

**지오메트리**

**지오메트리**

`FbxGeometry`는 제어점 변형을 지원하는 기하학적 객체의 기본 클래스입니다. `FbxGeometry`의 인스턴스는 `FbxNode::SetNodeAttribute()`를 통해 노드 속성으로 `FbxNode` 객체에 바인딩될 수 있습니다. `FbxGeometry`에서 상속하는 클래스에는 `FbxMesh`, `FbxNurb`, `FbxPatch` 및 `FbxLine`이 포함됩니다. `FbxGeometry`에서 상속하는 클래스의 전체 목록은 C++ 레퍼런스의 클래스 계층 구조를 참조하십시오.

자세한 내용은 **메시, 머티리얼 및 텍스처** 섹션을 참조하십시오.

---

**메시, 머티리얼 및 텍스처**

이 섹션은 FBX SDK의 메시, 텍스처 및 머티리얼을 제시합니다.

**메시**

메시는 `FbxMesh` 클래스에 의해 추상화됩니다. `FbxMesh`는 일반 문헌에서 정점(vertices)으로도 알려진 제어점 목록을 정의합니다. `FbxMesh`의 단일 인스턴스는 메모리 소비를 줄이기 위해 `FbxNode`의 여러 인스턴스에 바인딩될 수 있습니다. 이를 인스턴싱이라고 합니다. 씬 지오메트리는 레이어 및 레이어 요소(`FbxLayerElement`) 개념을 사용하여 노말 맵, 머티리얼 맵, 텍스처 맵 등을 정의합니다.

**머티리얼**

머티리얼(`FbxSurfaceLambert`, `FbxSurfacePhong`)은 `FbxNode::AddMaterial()`을 통해 `FbxNode`의 인스턴스에 바인딩됩니다. 머티리얼은 디퓨즈, 앰비언트 및 이미시브 색상 속성과 같은 씬의 지오메트리에 대한 기본 렌더링 특성을 정의합니다. 각 머티리얼은 `FbxNode`의 특정 인덱스를 차지하며, 이는 새로 생성된 폴리곤의 머티리얼을 정의하기 위해 `FbxMesh::BeginPolygon()`에서 참조될 수 있습니다.

**텍스처**

텍스처(`FbxFileTexture`, `FbxLayeredTexture`, `FbxProceduralTexture`)는 지오메트리가 렌더링되는 방식을 정의하기 위해 머티리얼 채널에 연결됩니다. `FbxFileTexture` 클래스는 예를 들어 `.jpg`와 같은 파일에 포함된 데이터를 사용하여 텍스처 값을 정의합니다.

---

**메시**

**메시 생성**

FBX SDK의 메시는 FbxMesh 클래스에 의해 추상화됩니다. 메시는 면당 정점 또는 "제어점" 세트와 메시의 노말, 텍스처 및 머티리얼을 정의하는 레이어 그룹에 의해 정의됩니다. 다음 코드 샘플은 FbxMesh를 인스턴스화하는 방법을 보여줍니다.

```cpp
// 씬에서 메시를 위한 노드를 생성합니다.
FbxNode* lMeshNode = FbxNode::Create(pScene, "meshNode");

// 메시를 생성합니다.
FbxMesh* lMesh = FbxMesh::Create(pScene, "mesh");

// 메시 노드의 노드 속성을 설정합니다.
lMeshNode->SetNodeAttribute(lMesh);

// 메시 노드를 씬의 루트 노드에 추가합니다.
FbxNode *lRootNode = pScene->GetRootNode();
lRootNode->AddChild(lMeshNode);
```

**제어점 정의**

FbxMesh의 면당 정점을 제어점이라고 합니다. FBX SDK의 객체는 기본적으로 오른손 좌표계, Y-Up 축 시스템에서 생성되므로 메시의 정점도 그에 따라 정의되어야 합니다. FbxMesh의 인스턴스는 특정 크기로 초기화할 수 있는 제어점 배열을 포함합니다. 예를 들어, 큐브의 메시는 24개의 제어점이 필요합니다: 면당 4개의 제어점이 있고, 큐브에는 6개의 면이 있습니다. 다음 코드 샘플은 큐브에 대한 제어점 배열을 초기화합니다.

```cpp
// 큐브의 8개 모서리를 정의합니다.
// 큐브는 다음 범위에 걸쳐 있습니다
//    X축을 따라 -50에서 50
//    Y축을 따라 0에서 100
//    Z축을 따라 -50에서 50
FbxVector4 vertex0(-50, 0, 50);
FbxVector4 vertex1(50, 0, 50);
FbxVector4 vertex2(50, 100, 50);
FbxVector4 vertex3(-50, 100, 50);
FbxVector4 vertex4(-50, 0, -50);
FbxVector4 vertex5(50, 0, -50);
FbxVector4 vertex6(50, 100, -50);
FbxVector4 vertex7(-50, 100, -50);

// 메시의 제어점 배열을 초기화합니다.
lMesh->InitControlPoints(24);
FbxVector4* lControlPoints = lMesh->GetControlPoints();

// 큐브의 각 면을 정의합니다.
// 면 1
lControlPoints[0] = vertex0;
lControlPoints[1] = vertex1;
lControlPoints[2] = vertex2;
lControlPoints[3] = vertex3;
// 면 2
lControlPoints[4] = vertex1;
lControlPoints[5] = vertex5;
lControlPoints[6] = vertex6;
lControlPoints[7] = vertex2;
// 면 3
lControlPoints[8] = vertex5;
lControlPoints[9] = vertex4;
lControlPoints[10] = vertex7;
lControlPoints[11] = vertex6;
// 면 4
lControlPoints[12] = vertex4;
lControlPoints[13] = vertex0;
lControlPoints[14] = vertex3;
lControlPoints[15] = vertex7;
// 면 5
lControlPoints[16] = vertex3;
lControlPoints[17] = vertex2;
lControlPoints[18] = vertex6;
lControlPoints[19] = vertex7;
// 면 6
lControlPoints[20] = vertex1;
lControlPoints[21] = vertex0;
lControlPoints[22] = vertex4;
lControlPoints[23] = vertex5;
```

제어점 관리에 대한 자세한 내용은 FbxGeometry 클래스 문서를 참조하십시오. FbxGeometry는 FbxMesh, FbxLine, FbxNurb 및 씬 지오메트리를 정의하는 데 사용되는 기타 클래스의 부모 클래스입니다.

**참고:** 씬 축 변환은 메시의 정점 값에 영향을 미치지 않습니다. 자세한 내용은 씬 축 및 단위 변환을 참조하십시오.

**노말 할당**

메시의 노말 벡터는 FbxLayerElementNormal의 인스턴스에 정의됩니다. 노말과 같은 레이어 요소는 제어점별(FbxLayerElement::eByControlPoint), 폴리곤 정점별(FbxLayerElement::eByPolygonVertex), 폴리곤별(FbxLayerElement::eByPolygon), 엣지별(FbxLayerElement::eByEdge) 또는 전체 표면에 대해 하나의 매핑 좌표(FbxLayerElement::eAllSame)와 같은 다양한 방식으로 메시 표면에 매핑될 수 있습니다. 자세한 내용은 FbxLayerElement::EMappingMode를 참조하십시오.

노말 벡터 배열과 제어점 배열이 주어지면, 노말 벡터 배열이 제어점 배열에 의해 참조되는 방식을 지정할 수 있습니다. 이는 FbxLayerElement::SetReferenceMode()에서 할당된 FbxLayerElement::EReferenceMode에 의해 정의됩니다. EReferenceMode::eDirect 모드는 노말 벡터 배열의 n번째 요소를 제어점 배열의 n번째 요소에 매핑합니다.

|참조 모드 (FbxLayerElement::EReferenceMode)|설명|
|---|---|
|FbxLayerElement::eDirect|n번째 요소에 대한 매핑 정보가 FbxLayerElementTemplate::mDirectArray의 n번째 위치에서 발견됨을 나타냅니다.|
|FbxLayerElement::eIndex|이 심볼은 FBX v5.0 파일과의 하위 호환성을 위해 유지됩니다. FBX v6.0 이상에서는 이 심볼이 FbxLayerElement::eIndexToDirect로 대체됩니다.|
|FbxLayerElement::eIndexToDirect|FbxLayerElementTemplate::mIndexArray의 각 요소가 FbxLayerElementTemplate::mDirectArray의 요소를 참조하는 인덱스를 포함함을 나타냅니다.|

다음 코드 샘플에서는 EReferenceMode::eDirect 참조 모드를 사용하여 제어점별 매핑(FbxLayerElement::eByControlPoint)을 메시에 적용하는 방법을 살펴보겠습니다. FbxLayerElementArrayTemplate::Add()가 호출되는 순서가 위에서 정의된 제어점의 순서에 해당한다는 점에 유의하십시오.

```cpp
// 각 축을 따라 노말 벡터를 정의합니다.
FbxVector4 lNormalXPos( 1,  0,  0);
FbxVector4 lNormalXNeg(-1,  0,  0);
FbxVector4 lNormalYPos( 0,  1,  0);
FbxVector4 lNormalYNeg( 0, -1,  0);
FbxVector4 lNormalZPos( 0,  0,  1);
FbxVector4 lNormalZNeg( 0,  0, -1);

// 메시에 레이어 0이 아직 존재하지 않으면 생성합니다.
// 여기서 노말을 정의할 것입니다.
FbxLayer lLayer = lMesh->GetLayer(0);
if(lLayer == NULL) {
    lMesh->CreateLayer();
    lLayer = lMesh->GetLayer(0);
}

// 노말 레이어를 생성합니다.
FbxLayerElementNormal* lLayerElementNormal= FbxLayerElementNormal::Create(lMesh, "");

// 각 노말 벡터를 각 제어점에 매핑하도록 매핑 모드를 설정합니다.
lLayerElementNormal->SetMappingMode(FbxLayerElement::eByControlPoint);

// 노말 배열의 n번째 요소가 제어점 배열의 n번째 요소에 매핑되도록
// 참조 모드를 설정합니다.
lLayerElementNormal->SetReferenceMode(FbxLayerElement::eDirect);

// 메시에 대해 제어점이 정의된 순서와 동일한 순서로 노말 벡터를 할당합니다.
// 면 1
lLayerElementNormal->GetDirectArray().Add(lNormalZPos);
lLayerElementNormal->GetDirectArray().Add(lNormalZPos);
lLayerElementNormal->GetDirectArray().Add(lNormalZPos);
lLayerElementNormal->GetDirectArray().Add(lNormalZPos);
// 면 2
lLayerElementNormal->GetDirectArray().Add(lNormalXPos);
lLayerElementNormal->GetDirectArray().Add(lNormalXPos);
lLayerElementNormal->GetDirectArray().Add(lNormalXPos);
lLayerElementNormal->GetDirectArray().Add(lNormalXPos);
// 면 3
lLayerElementNormal->GetDirectArray().Add(lNormalZNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalZNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalZNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalZNeg);
// 면 4
lLayerElementNormal->GetDirectArray().Add(lNormalXNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalXNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalXNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalXNeg);
// 면 5
lLayerElementNormal->GetDirectArray().Add(lNormalYPos);
lLayerElementNormal->GetDirectArray().Add(lNormalYPos);
lLayerElementNormal->GetDirectArray().Add(lNormalYPos);
lLayerElementNormal->GetDirectArray().Add(lNormalYPos);
// 면 6
lLayerElementNormal->GetDirectArray().Add(lNormalYNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalYNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalYNeg);
lLayerElementNormal->GetDirectArray().Add(lNormalYNeg);

// 마지막으로, 메시의 레이어 0을 노말 레이어 요소로 설정합니다.
lLayer->SetNormals(lLayerElementNormal);
```

---

**인스턴싱 - 메시 공유**

메모리 요구 사항을 줄이기 위해 `FbxMesh`의 단일 인스턴스를 FbxNode의 여러 인스턴스에 바인딩할 수 있습니다. 모든 큐브가 동일하게 보이지만 수천 개가 필요한 프로그램이 필요하다고 상상해보십시오. 프로그램이 시작될 때 하나의 `FbxMesh` 객체를 생성하여 메모리를 절약할 수 있습니다. 그런 다음 새 큐브가 필요할 때마다 새 `FbxNode` 객체를 생성한 다음 해당 노드가 하나의 메시를 가리키도록 합니다. 이를 인스턴싱이라고 합니다.

일반적으로 많은 노드 객체가 하나의 노드 속성 객체(즉, `FbxNodeAttribute`의 하위 클래스의 객체 하나)를 공유하도록 하여 메모리를 절약할 수 있습니다. 다음 함수는 `FbxMesh`를 새로 생성된 노드에 바인딩하는 방법을 보여줍니다.

```cpp
// 주어진 메시를 노드 속성으로 하는 큐브 인스턴스를 생성하고 씬에 추가합니다.
FbxNode* CreateCubeInstance(FbxScene* pScene, const char* pName, FbxMesh* pFirstCube)
{
    // FbxNode를 생성합니다
    FbxNode* lNode = FbxNode::Create(pScene,pName);

    // 노드 속성을 설정합니다
    lNode->SetNodeAttribute(pFirstCube);

    // 큐브의 크기를 조정합니다
    lNode->LclScaling.Set(FbxVector4(0.3, 0.3, 0.3));

        // 씬에 노드를 추가합니다
    pScene->GetRootNode()->AddChild(lNode);

    // FbxNode를 반환합니다
    return lNode;
}
```

각 노드는 메시, NURBS 또는 기타 씬 요소의 인스턴스입니다. 씬을 FBX 파일로 내보내면 인스턴싱도 파일 크기를 줄입니다. 여러 노드가 텍스처, 머티리얼, 애니메이션 커브 등을 공유하도록 하여 메모리를 절약할 수도 있습니다.

---

**머티리얼**

**참고:** 이 주제의 샘플 코드는 ExportScene03/main.cxx 샘플 프로그램에도 제시되어 있습니다.

**머티리얼 생성**

FbxSurfaceMaterial 클래스는 람베르시안(FbxSurfaceLambert) 및 퐁(FbxSurfacePhong) 머티리얼의 기본 클래스입니다. 다음 코드 샘플에서는 5개의 머티리얼을 생성하고 FbxNode::AddMaterial()을 통해 FbxMesh의 FbxNode에 추가합니다. 머티리얼이 노드에 바인딩되면 메시의 폴리곤에 매핑할 수 있습니다.

```cpp
// 피라미드에 대한 머티리얼을 생성합니다.
void CreateMaterials(FbxScene* pScene, FbxMesh* pMesh)
{
    int i;

    for (i = 0; i < 5; i++ )
    {
        FbxString lMaterialName = "material";
        FbxString lShadingName = "Phong";
        lMaterialName += i;
        FbxDouble3 lBlack(0.0, 0.0, 0.0);
        FbxDouble3 lRed(1.0, 0.0, 0.0);
        FbxDouble3 lColor;
        FbxSurfacePhong *lMaterial = FbxSurfacePhong::Create(pScene, lMaterialName.Buffer());


        // 기본 색상과 보조 색상을 생성합니다.
        lMaterial->Emissive.Set(lBlack);
        lMaterial->Ambient.Set(lRed);
        lColor = FbxDouble3(i > 2   ? 1.0 : 0.0,
            i > 0 && i < 4 ? 1.0 : 0.0,
            i % 2   ? 0.0 : 1.0);
        lMaterial->Diffuse.Set(lColor);
        lMaterial->TransparencyFactor.Set(0.0);
        lMaterial->ShadingModel.Set(lShadingName);
        lMaterial->Shininess.Set(0.5);

        // 메시의 노드를 가져와서 머티리얼을 추가합니다.
        FbxNode* lNode = pMesh->GetNode();
        if(lNode)             
            lNode->AddMaterial(lMaterial);
    }  
}
```

**예제: 머티리얼이 있는 사각 피라미드 생성**

다음 코드 샘플은 위에 정의된 CreateMaterials() 함수를 사용하여 5개의 머티리얼을 사각 피라미드의 5개 면에 바인딩합니다. 먼저 피라미드의 제어점과 노말을 정의하는 것으로 시작합니다.

```cpp
// 머티리얼이 있는 피라미드를 생성합니다.
FbxNode* CreatePyramidWithMaterials(FbxScene* pScene, char* pName)
{
    int i, j;
    FbxMesh* lMesh = FbxMesh::Create(pScene, pName);

    FbxVector4 vertex0(-50, 0, 50);
    FbxVector4 vertex1(50, 0, 50);
    FbxVector4 vertex2(50, 0, -50);
    FbxVector4 vertex3(-50, 0, -50);
    FbxVector4 vertex4(0, 100, 0);

    FbxVector4 lNormalP0(0, 1, 0);
    FbxVector4 lNormalP1(0, 0.447, 0.894);
    FbxVector4 lNormalP2(0.894, 0.447, 0);
    FbxVector4 lNormalP3(0, 0.447, -0.894);
    FbxVector4 lNormalP4(-0.894, 0.447, 0);

    // 제어점을 생성합니다.
    lMesh->InitControlPoints(16);
    FbxVector4* lControlPoints = lMesh->GetControlPoints();

    lControlPoints[0] = vertex0;
    lControlPoints[1] = vertex1;
    lControlPoints[2] = vertex2;
    lControlPoints[3] = vertex3;
    lControlPoints[4] = vertex0;
    lControlPoints[5] = vertex1;
    lControlPoints[6] = vertex4;
    lControlPoints[7] = vertex1;
    lControlPoints[8] = vertex2;
    lControlPoints[9] = vertex4;
    lControlPoints[10] = vertex2;
    lControlPoints[11] = vertex3;
    lControlPoints[12] = vertex4;
    lControlPoints[13] = vertex3;
    lControlPoints[14] = vertex0;
    lControlPoints[15] = vertex4;

    // 제어점당 노말을 지정합니다.

    FbxGeometryElementNormal* lNormalElement= lMesh->CreateElementNormal();
    lNormalElement->SetMappingMode(FbxGeometryElement::eByControlPoint);
    lNormalElement->SetReferenceMode(FbxGeometryElement::eDirect);

    lNormalElement->GetDirectArray().Add(lNormalP0);
    lNormalElement->GetDirectArray().Add(lNormalP0);
    lNormalElement->GetDirectArray().Add(lNormalP0);
    lNormalElement->GetDirectArray().Add(lNormalP0);
    lNormalElement->GetDirectArray().Add(lNormalP1);
    lNormalElement->GetDirectArray().Add(lNormalP1);
    lNormalElement->GetDirectArray().Add(lNormalP1);
    lNormalElement->GetDirectArray().Add(lNormalP2);
    lNormalElement->GetDirectArray().Add(lNormalP2);
    lNormalElement->GetDirectArray().Add(lNormalP2);
    lNormalElement->GetDirectArray().Add(lNormalP3);
    lNormalElement->GetDirectArray().Add(lNormalP3);
    lNormalElement->GetDirectArray().Add(lNormalP3);
    lNormalElement->GetDirectArray().Add(lNormalP4);
    lNormalElement->GetDirectArray().Add(lNormalP4);
    lNormalElement->GetDirectArray().Add(lNormalP4);
```

그런 다음 머티리얼이 메시의 폴리곤 제어점에 바인딩되도록 지정하기 위해 메시 내에 새 머티리얼 레이어 요소(FbxGeometryElementMaterial)를 생성합니다. FbxMesh::BeginPolygon() 함수는 인덱스를 사용하여 새 폴리곤에 바인딩될 머티리얼을 결정합니다. 이 인덱스는 FbxNode에 저장된 머티리얼의 위치를 참조합니다.

```cpp
// 폴리곤 정점 배열.
    int lPolygonVertices[] = { 0, 3, 2, 1,
        4, 5, 6,
        7, 8, 9,
        10, 11, 12,
        13, 14, 15 };

    // 머티리얼 매핑을 설정합니다.
    FbxGeometryElementMaterial* lMaterialElement = lMesh->CreateElementMaterial();
    lMaterialElement->SetMappingMode(FbxGeometryElement::eByPolygon);
    lMaterialElement->SetReferenceMode(FbxGeometryElement::eIndexToDirect);

    // 폴리곤을 생성합니다. 머티리얼 인덱스를 할당합니다.

    // 피라미드 밑면.
    lMesh->BeginPolygon(0); // 머티리얼 인덱스.

    for(j = 0; j < 4; j++)
    {
        lMesh->AddPolygon(lPolygonVertices[j]); // 제어점 인덱스.
    }

    lMesh->EndPolygon ();

    // 피라미드 측면.
    for(i = 1; i < 5; i++)
    {
        lMesh->BeginPolygon(i); // 머티리얼 인덱스.

        for(j = 0; j < 3; j++)
        {
            lMesh->AddPolygon(lPolygonVertices[4 + 3*(i - 1) + j]); // 제어점 인덱스.
        }

        lMesh->EndPolygon ();
    }


    FbxNode* lNode = FbxNode::Create(pScene,pName);

    lNode->SetNodeAttribute(lMesh);

    CreateMaterials(pScene, lMesh);

    return lNode;
}
```

---

**하드웨어 셰이더를 사용하여 머티리얼 생성**

CGFX 및 DirectX 하드웨어 셰이더는 FBX SDK 버전 2010부터 지원됩니다. `FbxImplementation` 클래스와 `FbxBindingTable` 클래스를 사용하여 CGFX 또는 DirectX 구현으로 머티리얼을 설정할 수 있습니다.

---

**텍스처**

**참고:** 이 주제의 샘플 코드는 ExportScene03/main.cxx 샘플 프로그램에도 제시되어 있습니다.

**파일에서 텍스처 생성**

FbxTexture는 FBX SDK의 텍스처에 대한 기본 클래스입니다. 텍스처는 지오메트리가 렌더링되는 방식에 영향을 주기 위해 기본 머티리얼에 의존합니다. 다음 코드 샘플에서는 Phong 머티리얼의 디퓨즈, 앰비언트 및 이미시브 채널을 FbxFileTexture의 세 가지 개별 인스턴스에 연결합니다. FbxFileTexture는 파일에서 로드된 모든 텍스처를 나타냅니다. 파일에서 임베디드 또는 비임베디드 미디어를 참조하는 방법에 대한 자세한 내용은 미디어 참조를 참조하십시오.

```cpp
// 큐브에 대한 텍스처를 생성합니다.
void CreateTexture(FbxScene* pScene, FbxMesh* pMesh)
{
    // 텍스처는 머티리얼의 속성에 연결되어야 하므로
    // 머티리얼이 있으면 사용하고 없으면 새로 만듭니다
    FbxSurfacePhong* lMaterial = NULL;

    // 메시의 노드를 가져와서 머티리얼을 추가합니다.
    FbxNode* lNode = pMesh->GetNode();
    if(lNode)
    {
        lMaterial = lNode->GetSrcObject<FbxSurfacePhong>(0);
        if (lMaterial == NULL)
        {
            FbxString lMaterialName = "toto";
            FbxString lShadingName  = "Phong";
            FbxDouble3 lBlack(0.0, 0.0, 0.0);
            FbxDouble3 lRed(1.0, 0.0, 0.0);
            FbxDouble3 lDiffuseColor(0.75, 0.75, 0.0);
            lMaterial = FbxSurfacePhong::Create(pScene, lMaterialName.Buffer());

            // 기본 색상과 보조 색상을 생성합니다.
            lMaterial->Emissive           .Set(lBlack);
            lMaterial->Ambient            .Set(lRed);
            lMaterial->AmbientFactor      .Set(1.);
            // 디퓨즈 채널에 텍스처 추가
            lMaterial->Diffuse           .Set(lDiffuseColor);
            lMaterial->DiffuseFactor     .Set(1.);
            lMaterial->TransparencyFactor.Set(0.4);
            lMaterial->ShadingModel      .Set(lShadingName);
            lMaterial->Shininess         .Set(0.5);
            lMaterial->Specular          .Set(lBlack);
            lMaterial->SpecularFactor    .Set(0.3);

            lNode->AddMaterial(lMaterial);
        }
    }

    FbxFileTexture* lTexture = FbxFileTexture::Create(pScene,"Diffuse Texture");

    // 텍스처 속성을 설정합니다.
    lTexture->SetFileName("scene03.jpg"); // 리소스 파일은 현재 디렉토리에 있습니다.
    lTexture->SetTextureUse(FbxTexture::eStandard);
    lTexture->SetMappingType(FbxTexture::eUV);
    lTexture->SetMaterialUse(FbxFileTexture::eModelMaterial);
    lTexture->SetSwapUV(false);
    lTexture->SetTranslation(0.0, 0.0);
    lTexture->SetScale(1.0, 1.0);
    lTexture->SetRotation(0.0, 0.0);

    // 텍스처를 머티리얼의 해당 속성에 연결하는 것을 잊지 마십시오
    if (lMaterial)
        lMaterial->Diffuse.ConnectSrcObject(lTexture);

    lTexture = FbxFileTexture::Create(pScene,"Ambient Texture");

    // 텍스처 속성을 설정합니다.
    lTexture->SetFileName("gradient.jpg"); // 리소스 파일은 현재 디렉토리에 있습니다.
    lTexture->SetTextureUse(FbxTexture::eStandard);
    lTexture->SetMappingType(FbxTexture::eUV);
    lTexture->SetMaterialUse(FbxFileTexture::eModelMaterial);
    lTexture->SetSwapUV(false);
    lTexture->SetTranslation(0.0, 0.0);
    lTexture->SetScale(1.0, 1.0);
    lTexture->SetRotation(0.0, 0.0);

    // 텍스처를 머티리얼의 해당 속성에 연결하는 것을 잊지 마십시오
    if (lMaterial)
        lMaterial->Ambient.ConnectSrcObject(lTexture);

    lTexture = FbxFileTexture::Create(pScene,"Emissive Texture");

    // 텍스처 속성을 설정합니다.
    lTexture->SetFileName("spotty.jpg"); // 리소스 파일은 현재 디렉토리에 있습니다.
    lTexture->SetTextureUse(FbxTexture::eStandard);
    lTexture->SetMappingType(FbxTexture::eUV);
    lTexture->SetMaterialUse(FbxFileTexture::eModelMaterial);
    lTexture->SetSwapUV(false);
    lTexture->SetTranslation(0.0, 0.0);
    lTexture->SetScale(1.0, 1.0);
    lTexture->SetRotation(0.0, 0.0);

    // 텍스처를 머티리얼의 해당 속성에 연결하는 것을 잊지 마십시오
    if (lMaterial)
        lMaterial->Emissive.ConnectSrcObject(lTexture);
}
```

**예제: 텍스처가 있는 큐브 생성**

다음 코드 샘플은 위에서 정의한 CreateTexture() 함수를 사용합니다. 먼저 큐브의 제어점과 노말을 정의하는 것으로 시작합니다.

```cpp
// 텍스처가 있는 큐브를 생성합니다.
FbxNode* CreateCubeWithTexture(FbxScene* pScene, char* pName)
{
    int i, j;
    FbxMesh* lMesh = FbxMesh::Create(pScene,pName);

    FbxVector4 vertex0(-50, 0, 50);
    FbxVector4 vertex1(50, 0, 50);
    FbxVector4 vertex2(50, 100, 50);
    FbxVector4 vertex3(-50, 100, 50);
    FbxVector4 vertex4(-50, 0, -50);
    FbxVector4 vertex5(50, 0, -50);
    FbxVector4 vertex6(50, 100, -50);
    FbxVector4 vertex7(-50, 100, -50);

    FbxVector4 lNormalXPos(1, 0, 0);
    FbxVector4 lNormalXNeg(-1, 0, 0);
    FbxVector4 lNormalYPos(0, 1, 0);
    FbxVector4 lNormalYNeg(0, -1, 0);
    FbxVector4 lNormalZPos(0, 0, 1);
    FbxVector4 lNormalZNeg(0, 0, -1);

    // 제어점을 생성합니다.
    lMesh->InitControlPoints(24);
    FbxVector4* lControlPoints = lMesh->GetControlPoints();

    lControlPoints[0] = vertex0;
    lControlPoints[1] = vertex1;
    lControlPoints[2] = vertex2;
    lControlPoints[3] = vertex3;
    lControlPoints[4] = vertex1;
    lControlPoints[5] = vertex5;
    lControlPoints[6] = vertex6;
    lControlPoints[7] = vertex2;
    lControlPoints[8] = vertex5;
    lControlPoints[9] = vertex4;
    lControlPoints[10] = vertex7;
    lControlPoints[11] = vertex6;
    lControlPoints[12] = vertex4;
    lControlPoints[13] = vertex0;
    lControlPoints[14] = vertex3;
    lControlPoints[15] = vertex7;
    lControlPoints[16] = vertex3;
    lControlPoints[17] = vertex2;
    lControlPoints[18] = vertex6;
    lControlPoints[19] = vertex7;
    lControlPoints[20] = vertex1;
    lControlPoints[21] = vertex0;
    lControlPoints[22] = vertex4;
    lControlPoints[23] = vertex5;


    // 각 정점(또는 제어점)에 대해 하나의 노말을 갖도록 하므로
    // 매핑 모드를 eByControlPoint로 설정합니다.
    FbxGeometryElementNormal* lGeometryElementNormal= lMesh->CreateElementNormal();

    lGeometryElementNormal->SetMappingMode(FbxGeometryElement::eByControlPoint);

    // 노말 값을 설정하는 두 가지 방법이 있습니다.
    bool firstWayNormalCalculations=true;
    if (firstWayNormalCalculations)
    {    
        // 첫 번째 방법은 모든 제어점에 대해 
        // 실제 노말 값을 설정하는 것입니다.
        lGeometryElementNormal->SetReferenceMode(FbxGeometryElement::eDirect);

        lGeometryElementNormal->GetDirectArray().Add(lNormalZPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYNeg);
    }
    else
    {
        // 두 번째 방법은 노말의 가능한 값을
        // direct 배열에 넣고, 모든 제어점에 대해
        // 인덱스 배열에 해당 값의 인덱스를 설정하는 것입니다.
        lGeometryElementNormal->SetReferenceMode(FbxGeometryElement::eIndexToDirect);

        // direct 배열에 6개의 다른 노말을 추가합니다
        lGeometryElementNormal->GetDirectArray().Add(lNormalZPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalZNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalXNeg);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYPos);
        lGeometryElementNormal->GetDirectArray().Add(lNormalYNeg);

        // 이제 각 제어점에 대해 사용할 노말을 지정해야 합니다
        lGeometryElementNormal->GetIndexArray().Add(0); // direct 배열의 lNormalZPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(0); // direct 배열의 lNormalZPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(0); // direct 배열의 lNormalZPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(0); // direct 배열의 lNormalZPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(1); // direct 배열의 lNormalXPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(1); // direct 배열의 lNormalXPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(1); // direct 배열의 lNormalXPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(1); // direct 배열의 lNormalXPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(2); // direct 배열의 lNormalZNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(2); // direct 배열의 lNormalZNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(2); // direct 배열의 lNormalZNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(2); // direct 배열의 lNormalZNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(3); // direct 배열의 lNormalXNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(3); // direct 배열의 lNormalXNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(3); // direct 배열의 lNormalXNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(3); // direct 배열의 lNormalXNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(4); // direct 배열의 lNormalYPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(4); // direct 배열의 lNormalYPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(4); // direct 배열의 lNormalYPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(4); // direct 배열의 lNormalYPos 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(5); // direct 배열의 lNormalYNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(5); // direct 배열의 lNormalYNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(5); // direct 배열의 lNormalYNeg 인덱스.
        lGeometryElementNormal->GetIndexArray().Add(5); // direct 배열의 lNormalYNeg 인덱스.
    }
```

그런 다음 FbxMesh::CreateElementUV()를 호출하여 메시에 세 개의 새 텍스처 레이어를 생성합니다 - 디퓨즈, 앰비언트 및 이미시브 머티리얼 채널 각각에 대해 하나씩. 결과 텍스처 레이어 요소(FbxGeometryElementUV)는 텍스처의 UV 좌표를 각 폴리곤의 정점에 매핑하는 방법을 정의합니다. 마지막으로 FbxNode::SetShadingMode()를 FbxNode::eTextureShading 값으로 호출하여 텍스처가 씬에서 렌더링되도록 합니다.

```cpp
    // 폴리곤 정점 배열.
    int lPolygonVertices[] = { 0, 1, 2, 3,
        4, 5, 6, 7,
        8, 9, 10, 11,
        12, 13, 14, 15,
        16, 17, 18, 19,
        20, 21, 22, 23 };

    // Diffuse 채널에 대한 UV 생성
    FbxGeometryElementUV* lUVDiffuseElement = lMesh->CreateElementUV( "DiffuseUV");
    K_ASSERT( lUVDiffuseElement != NULL);
    lUVDiffuseElement->SetMappingMode(FbxGeometryElement::eByPolygonVertex);
    lUVDiffuseElement->SetReferenceMode(FbxGeometryElement::eIndexToDirect);

    FbxVector2 lVectors0(0, 0);
    FbxVector2 lVectors1(1, 0);
    FbxVector2 lVectors2(1, 1);
    FbxVector2 lVectors3(0, 1);

    lUVDiffuseElement->GetDirectArray().Add(lVectors0);
    lUVDiffuseElement->GetDirectArray().Add(lVectors1);
    lUVDiffuseElement->GetDirectArray().Add(lVectors2);
    lUVDiffuseElement->GetDirectArray().Add(lVectors3);


    // Ambient 채널에 대한 UV 생성
    FbxGeometryElementUV* lUVAmbientElement = lMesh->CreateElementUV("AmbientUV");

    lUVAmbientElement->SetMappingMode(FbxGeometryElement::eByPolygonVertex);
    lUVAmbientElement->SetReferenceMode(FbxGeometryElement::eIndexToDirect);

    lVectors0.Set(0, 0);
    lVectors1.Set(1, 0);
    lVectors2.Set(0, 0.418586879968643);
    lVectors3.Set(1, 0.418586879968643);

    lUVAmbientElement->GetDirectArray().Add(lVectors0);
    lUVAmbientElement->GetDirectArray().Add(lVectors1);
    lUVAmbientElement->GetDirectArray().Add(lVectors2);
    lUVAmbientElement->GetDirectArray().Add(lVectors3);

    // Emissive 채널에 대한 UV 생성
    FbxGeometryElementUV* lUVEmissiveElement = lMesh->CreateElementUV("EmissiveUV");

    lUVEmissiveElement->SetMappingMode(FbxGeometryElement::eByPolygonVertex);
    lUVEmissiveElement->SetReferenceMode(FbxGeometryElement::eIndexToDirect);

    lVectors0.Set(0.2343, 0);
    lVectors1.Set(1, 0.555);
    lVectors2.Set(0.333, 0.999);
    lVectors3.Set(0.555, 0.666);

    lUVEmissiveElement->GetDirectArray().Add(lVectors0);
    lUVEmissiveElement->GetDirectArray().Add(lVectors1);
    lUVEmissiveElement->GetDirectArray().Add(lVectors2);
    lUVEmissiveElement->GetDirectArray().Add(lVectors3);

    // 이제 UV를 eIndexToDirect 참조와 eByPolygonVertex 매핑 모드로 설정했으므로
    // 인덱스 배열의 크기를 업데이트해야 합니다.
    lUVDiffuseElement->GetIndexArray().SetCount(24);
    lUVAmbientElement->GetIndexArray().SetCount(24);
    lUVEmissiveElement->GetIndexArray().SetCount(24);



    // 폴리곤을 생성합니다. 텍스처 및 텍스처 UV 인덱스를 할당합니다.
    for(i = 0; i < 6; i++)
    {
        // 기본(디퓨즈) 채널 이상에 텍스처가 있으므로
        // 기본 방식의 텍스처 할당을 사용하지 않습니다.
        lMesh->BeginPolygon(-1, -1, false);



        for(j = 0; j < 4; j++)
        {
            // 이 함수는 포인트를 지정합니다
            lMesh->AddPolygon(lPolygonVertices[i*4 + j] // 제어점 인덱스.
            );
            // 이제 디퓨즈, 앰비언트 및 이미시브에 대한 UV의 인덱스 배열을 업데이트해야 합니다
            lUVDiffuseElement->GetIndexArray().SetAt(i*4+j, j);
            lUVAmbientElement->GetIndexArray().SetAt(i*4+j, j);
            lUVEmissiveElement->GetIndexArray().SetAt(i*4+j, j);

        }

        lMesh->EndPolygon ();
    }

    FbxNode* lNode = FbxNode::Create(pScene,pName);

    lNode->SetNodeAttribute(lMesh);
    lNode->SetShadingMode(FbxNode::eTextureShading);

    CreateTexture(pScene, lMesh);

    return lNode;
}
```

---

**레이어드 텍스처**

이 튜토리얼 주제에서는 FbxLayeredTexture를 사용하여 4개의 FbxFileTexture 인스턴스를 레이어링하는 방법을 제시합니다. 또한 FbxLayerElement 개념을 확장하여 메시의 노말과 UV 좌표를 정의합니다. 이 주제의 코드는 Python으로 작성되었으며, C++에도 직접 적용됩니다.

**예제: 4개의 텍스처 레이어링**

필요한 리소스: 왼쪽에서 오른쪽으로: "one.jpg", "two.jpg", "three.jpg", "four.jpg". 이 파일들의 너비와 높이가 2의 배수(128x128)임을 확인하십시오. 이는 텍스처 치수에 권장됩니다.

샘플 출력: 이 스크린샷은 Python 프로그램을 실행하고 결과 .fbx 파일을 Autodesk MotionBuilder로 가져온 후 촬영되었습니다.

프로그램 요약: 아래 Python 프로그램은 씬을 생성하고 .fbx 파일로 내보냅니다. 이 씬에는 FbxLayeredTexture 인스턴스를 사용하여 텍스처가 적용된 평면 메시가 포함됩니다. 이 FbxLayeredTexture 인스턴스는 가산 블렌딩된 4개의 FbxFileTexture 인스턴스로 구성됩니다. FbxLayeredTexture는 FbxSurfaceLambert 인스턴스의 디퓨즈 속성에 연결됩니다. 다음 다이어그램에서 볼 수 있듯이 이 FbxSurfaceLambert 인스턴스는 FbxNode의 머티리얼 목록에 추가됩니다.

평면 FbxMesh는 FbxNode의 속성으로 설정됩니다. 이 메시의 노말 값과 UV 좌표는 FbxLayerElementNormal 및 FbxLayerElementUV를 사용하여 0번째 FbxLayer 내에 설정됩니다. FbxMesh.BeginPolygon()이 매개변수로 '0'과 함께 호출될 때 머티리얼이 평면 폴리곤에 바인딩됩니다. 이 0은 부모 FbxNode의 머티리얼 목록에 포함된 (유일한) 머티리얼, 즉 이전에 언급한 FbxSurfaceLambert를 참조합니다.

**참고:** 이 Python 프로그램을 성공적으로 실행하려면 프로그램이 실행될 때 위의 4개의 .jpg 이미지가 이 Python 프로그램과 같은 폴더에 있는지 확인하십시오.

python

```python
'''
layeredTextures.py

    > 4개의 텍스처가 서로 위에 레이어링된 평면을 씬에 생성합니다.

    > 필요한 텍스처 파일: one.jpg, two.jpg, three.jpg, four.jpg
'''

import fbx
import FbxCommon

vertices = [fbx.FbxVector4( -5, -5,  0 ), # 0 - 정점 인덱스.
            fbx.FbxVector4(  5, -5,  0 ), # 1
            fbx.FbxVector4(  5,  5,  0 ), # 2
            fbx.FbxVector4( -5,  5,  0 )] # 3

normalPosZ = fbx.FbxVector4( 0, 0, 1 ) # 양의 Z 노말 벡터.

# 각 텍스처의 파일명과 알파 투명도를 정의합니다.
textureFilenames = [ ( 'one.jpg',   0.2 ),
                     ( 'two.jpg',   0.5 ),
                     ( 'three.jpg', 0.4 ),
                     ( 'four.jpg',  1.0 ) ]

saveFilename = 'layeredTextures.fbx'

###############################################################
# 헬퍼 함수(들).                                              #
###############################################################
def createPlane(pScene):
    ''' 루트 노드의 자식으로 평면 폴리곤을 생성합니다. '''

    rootNode = pScene.GetRootNode()

    #======================================================
    # 노드 정의 및 메시 객체 생성.
    #======================================================
    # 노드를 생성합니다.
    newNode = fbx.FbxNode.Create( pScene, 'planeNode' )
    rootNode.AddChild( newNode )

    # 메시 노드 속성을 생성합니다.
    newMesh = fbx.FbxMesh.Create( pScene, 'planeMesh' )
    newNode.SetNodeAttribute( newMesh )

    # Lambert 머티리얼을 생성하고 메시의 노드에 할당합니다.
    applyLambertMaterial( pScene, newNode )

    # 레이어드 텍스처를 생성하고 적용합니다.
    applyLayeredTexture( pScene, newNode )

    # 텍스처를 보기 위해 노드의 셰이딩 모드를 설정합니다.
    newNode.SetShadingMode( fbx.FbxNode.eTextureShading )

    #======================================================
    # 제어점.
    #======================================================
    # 폴리곤의 정점을 정의합니다.
    global vertices
    newMesh.InitControlPoints( 4 )
    newMesh.SetControlPointAt( vertices[0], 0 )
    newMesh.SetControlPointAt( vertices[1], 1 )
    newMesh.SetControlPointAt( vertices[2], 2 )
    newMesh.SetControlPointAt( vertices[3], 3 )

    #======================================================
    # 노말.
    #======================================================
    # 노말과 UV 좌표의 경우 인덱스 0의 레이어를 사용합니다.
    # 존재하지 않으면 생성합니다.
    layer = newMesh.GetLayer( 0 )
    if( not layer ):
        newMesh.CreateLayer()
        layer = newMesh.GetLayer( 0 )

    # 노말 레이어 요소를 생성합니다.
    normalLayerElement = fbx.FbxLayerElementNormal.Create( newMesh, 'normals' )

    # 각 정점(또는 제어점)에 대해 하나의 노말을 갖도록 하므로
    # 매핑 모드를 eByControlPoint로 설정합니다
    normalLayerElement.SetMappingMode( fbx.FbxLayerElement.eByControlPoint )

    # 모든 제어점에 대한 노말 값을 설정합니다.
    normalLayerElement.SetReferenceMode( fbx.FbxLayerElement.eDirect )

    global normalPosZ # 양의 Z 노말.
    normalLayerElement.GetDirectArray().Add( normalPosZ )
    normalLayerElement.GetDirectArray().Add( normalPosZ )
    normalLayerElement.GetDirectArray().Add( normalPosZ )
    normalLayerElement.GetDirectArray().Add( normalPosZ )

    # 노말 레이어 요소를 메시의 레이어 0에 할당합니다.
    layer.SetNormals( normalLayerElement )

    #======================================================
    # Diffuse 채널 UV 좌표.
    #======================================================
    # 하나의 폴리곤(사각형 평면)만 다루므로
    # 코드를 단순화하고 uv 좌표를 4개의 폴리곤 제어점에 직접 매핑할 수 있습니다.
    uvDiffuseLayerElement = fbx.FbxLayerElementUV.Create( newMesh, 'diffuseUV' )
    uvDiffuseLayerElement.SetMappingMode( fbx.FbxLayerElement.eByPolygonVertex )
    uvDiffuseLayerElement.SetReferenceMode( fbx.FbxLayerElement.eDirect )

    # direct 배열을 채웁니다.
    uv0 = fbx.FbxVector2( 0, 0 )
    uv1 = fbx.FbxVector2( 1, 0 )
    uv2 = fbx.FbxVector2( 1, 1 )
    uv3 = fbx.FbxVector2( 0, 1 )
    uvDiffuseLayerElement.GetDirectArray().Add( uv0 )
    uvDiffuseLayerElement.GetDirectArray().Add( uv1 )
    uvDiffuseLayerElement.GetDirectArray().Add( uv2 )
    uvDiffuseLayerElement.GetDirectArray().Add( uv3 )

    # uv 레이어 요소를 메시의 레이어 0에 할당합니다.
    layer.SetUVs( uvDiffuseLayerElement, fbx.FbxLayerElement.eTextureDiffuse )

    #======================================================
    # 폴리곤 정의.
    #======================================================
    # 하나의 평면 폴리곤을 생성합니다.
    #    > FbxMesh.BeginPolygon()의 0은 폴리곤에 적용될 머티리얼의 인덱스를 참조합니다.
    #      FbxNode에 적용된 머티리얼이 하나만 있으므로 인덱스 0을 사용합니다.
    newMesh.BeginPolygon( 0 )
    for i in range( 0, 4 ):
        newMesh.AddPolygon( i )
    newMesh.EndPolygon()

    return newNode

def applyLambertMaterial( pScene, pNode ):
    ''' 노드에 Lambert 머티리얼을 적용합니다. '''

    black = fbx.FbxDouble3( 0, 0, 0 )
    white = fbx.FbxDouble3( 1, 1, 1 )

    material = fbx.FbxSurfaceLambert.Create( pScene, 'myMaterial' )
    material.ShadingModel.Set( 'Lambert' ) # FbxSurfacePhong 인스턴스를 사용하는 경우 'Phong'도 사용할 수 있습니다
    material.Emissive.Set( black )
    material.Ambient.Set( white )
    material.Diffuse.Set( white )
    material.TransparencyFactor.Set( 0 )

    pNode.AddMaterial( material )


def applyLayeredTexture( pScene, pNode ):
    ''' 주어진 텍스처 파일명을 사용하여 노드에 레이어드 텍스처를 적용합니다. '''
    global textureFilenames

    textures = []

    # 나중에 레이어링할 개별 텍스처 객체를 생성합니다.
    for i in range( 0, len( textureFilenames ) ):

        textureFilename = textureFilenames[i][0]
        textureAlpha = textureFilenames[i][1]

        newTexture = fbx.FbxFileTexture.Create( pScene, 'myFileTexture_' +  str( i ) )
        newTexture.SetFileName( textureFilename )

        newTexture.SetTextureUse( fbx.FbxTexture.eStandard )
        newTexture.SetMappingType( fbx.FbxTexture.eUV )
        newTexture.SetMaterialUse( fbx.FbxFileTexture.eModelMaterial )
        newTexture.SetSwapUV( False )
        newTexture.SetTranslation( 0.0, 0.0 )
        newTexture.SetScale( 1.0, 1.0 )
        newTexture.SetRotation( 0.0, 0.0 )
        newTexture.Alpha.Set( textureAlpha )

        textures.append( newTexture )

    # 레이어드 텍스처 객체를 생성하고 그 안에 텍스처를 레이어링합니다.
    layeredTexture = fbx.FbxLayeredTexture.Create( pScene, 'myLayeredTexture' )

    for i in range( 0, len( textures ) ):
        texture = textures[ i ]
        layeredTexture.ConnectSrcObject( texture )
        layeredTexture.SetTextureBlendMode( i, fbx.FbxLayeredTexture.eAdditive )

    # 레이어드 텍스처를 인덱스 0의 노드 머티리얼에 연결합니다.
    # 레이어드 텍스처는 머티리얼의 디퓨즈 채널에 연결됩니다.
    material = pNode.GetMaterial( 0 )
    material.Diffuse.ConnectSrcObject( layeredTexture )


###############################################################
# Main.                                                       #
###############################################################
def main():
    ''' 메인 프로그램. '''
    fbxManager = fbx.FbxManager.Create()
    fbxScene = fbx.FbxScene.Create( fbxManager, '' )

    # 텍스처가 적용된 평면 메시를 생성합니다.
    newNode = createPlane( fbxScene )

    # 파일을 저장합니다.
    global saveFilename
    FbxCommon.SaveScene( fbxManager, fbxScene, saveFilename, pEmbedMedia=True )

    # 정리합니다.
    fbxManager.Destroy()
    del fbxManager, fbxScene, newNode

if __name__ == '__main__':
    main()
```

**참고:**

- FbxLayerElementUV, FbxLayerElementNormal - UV 및 노말 정의
- FbxLayerElement::EMappingMode - 레이어 요소가 표면에 매핑되는 방법을 지정하는 열거형.
- FbxLayerElement::EReferenceMode - 레이어 요소의 IndexArray와 DirectArray가 참조되는 방법을 지정하는 열거형.

