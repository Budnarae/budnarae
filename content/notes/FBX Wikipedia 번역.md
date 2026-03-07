---
title: 'FBX Wikipedia 번역'
tags:
  - translation
  - graphics
---

_Filmbox_

---

# FBX

**이 문서는 추가적인 인용이 필요합니다**

|||
|---|---|
|파일명 확장자|.fbx|
|인터넷 미디어 타입|'FBX'|

**FBX**(Filmbox에서 유래)는 Kaydara가 개발하고 2006년부터 Autodesk가 소유하고 있는 독점 파일 형식(.fbx)입니다. 디지털 콘텐츠 제작 애플리케이션 간의 상호 운용성을 제공하는 데 사용됩니다. FBX는 또한 비디오 게임 미들웨어 시리즈인 Autodesk Gameware의 일부이기도 합니다.

## 역사

FBX는 캐나다 회사 Kaydara의 Filmbox를 위한 대체 파일 형식으로 시작되었습니다. Filmbox는 모션 캡처 장치에서 데이터를 기록하는 소프트웨어였습니다. 1996년 이전에 Filmbox 1.0은 FLM이라는 파일 형식을 사용했습니다. 이 형식은 모션 데이터, 사용자 기본 설정, 그리고 모션 데이터 캡처에 사용된 장치 목록만 지원했습니다. 이 데이터는 읽기/쓰기 메모리 데이터를 포함하는 라이브러리의 직렬화된 버전(바이너리 덤프)이었습니다. 이러한 데이터 저장 방식은 Filmbox의 다른 버전과 잘 작동하지 않았습니다. 또한 Filmbox의 초기 사용자들로부터 모션 캡처 데이터와 함께 장면에 타겟 캐릭터를 구현하여 디스플레이 마커와 함께 3D 뷰에서 데이터를 시각화할 수 있게 해달라는 요구가 있었습니다.

1996년, Kaydara는 Filmbox 1.5와 함께 FBX라는 새로운 네이티브 파일 형식을 출시했습니다. 이 형식은 객체 기반 모델을 사용하여 모션과 함께 2D, 3D, 오디오 및 비디오 데이터를 저장할 수 있었습니다. 이 형식은 Cinema 4D, SoftImage 3D, PowerAnimator, LightWave 3D, 3D Studio MAX 및 TurboCAD와 같은 다른 3D 소프트웨어 패키지에서 더 광범위한 지원을 받았습니다.

Filmbox는 2002년 버전 4.0 출시와 함께 MotionBuilder로 이름이 변경되었습니다. 2003년, Kaydara는 Apple의 QuickTime Viewer용 FBX를 출시했습니다. Alias는 2004년 8월 8일에 Kaydara를 인수하겠다는 의사를 발표했고, 9월에 합의에 도달했습니다. 2005년에는 객체 모델을 표준화하고 다른 소프트웨어 개발자들이 자체 플러그인을 제공할 수 있도록 하기 위해 소프트웨어 개발 키트가 개발되었습니다. Alias는 2006년 1월 10일 Autodesk에 인수되었습니다. 2006년 후반에 FBX에 속성(properties) 지원이 추가되었습니다.

## 기술 사양

FBX 파일 형식은 독점 형식입니다. 그러나 형식 설명은 FBX Extensions SDK에 공개되어 있으며, 이는 FBX 리더와 라이터를 위한 헤더 파일을 제공합니다.

Autodesk가 제공하는 C++ 및 Python용 두 가지 FBX SDK 바인딩이 있습니다. Blender는 FBX SDK를 사용하지 않고 작성된 FBX용 Python 가져오기 및 내보내기 스크립트를 포함하고 있으며[1], The OpenEnded Group의 Field는 FBX 파일에서 일부를 로드하고 추출하기 위한 Java 기반 라이브러리를 포함하고 있습니다.[2]

Godot 게임 엔진은 FBX SDK를 사용하지 않고 FBX 파일을 가져올 수 있습니다. Godot 3.2에서는 Assimp 라이브러리가 이를 처리했습니다.[3] 이는 Godot 3.3에서 다시 작성되었고[4], Godot 4.0에서는 Facebook의 FBX2glTF 유틸리티의 포크로 대체되었습니다.[5] 오픈소스 ufbx 임포터에 대한 지원은 Godot 4.3 릴리스에 추가되었습니다. Godot 4.3은 이전에 특정 파일에 사용된 임포터를 해당 파일의 기본 임포터로 유지함으로써 ufbx와 FBX2glTF가 함께 작동할 수 있게 합니다. 동일한 프로젝트의 새 FBX 파일은 기본적으로 ufbx를 사용합니다.[6]

### 파일 형식

FBX는 디스크에 바이너리 또는 ASCII 데이터로 표현될 수 있으며, SDK는 두 형식 모두의 읽기 및 쓰기를 지원합니다.

두 형식 모두 문서화되어 있지 않지만, ASCII 형식은 명확하게 명명된 식별자를 가진 트리 구조 문서입니다. FBX 바이너리 파일 형식의 경우, Blender Foundation이 비공식 사양을 발표했으며, FBX에서 실제 데이터가 어떻게 배치되는지에 대한 더 높은 수준의 비공식 사양(진행 중인 작업)도 발표했습니다(ASCII 또는 바이너리 형식과 무관).

### 버전

FBX 버전 목록(괄호 안은 대체 이름):

- 6.x (FBX 2006, FBX 2009, FBX 2010)
- 7.1 (FBX 2011)
- 7.2 (FBX 2012)
- 7.3 (FBX 2013)
- 7.4 (FBX 2014)
- 7.5 (FBX 2016.1.2)

## 참고 문헌

[1] ↑ Coumans, Erwin (2009-12-26). "FBX". Blender Foundation. Archived from the original on 2009-07-22. Retrieved 2009-12-26. 선택한 객체를 Autodesk의 .FBX 파일 형식으로 내보냅니다.

[2] ↑ Coumans, Erwin (2009-12-26). "Loading FBX files". OpenEndedGroup. Archived from the original on 2009-10-29. Retrieved 2009-12-26. Field에는 FBX 파일을 로드하고 흥미로운 부분을 추출하기 위한 Java 기반 라이브러리가 함께 제공됩니다.

[3] ↑ Lee, K. S. Ernest (iFire) (2018-11-19). "Add Open Asset Importer to Godot". Godot. Retrieved 2023-08-21. Open Asset Import Library(assimp)의 다양한 형식을 지원합니다. 주요 초점은 FBX와 MMD입니다.

[4] ↑ MacPherson, Gordon (2020-10-30). "FBX importer rewrite". Godot. Retrieved 2020-11-01. 이것은 임포터의 완전한 재작성입니다. 더 결정론적인 동작을 제공할 것입니다. 이 임포터 개발에 1년 이상이 소요되었으며 FBX SDK의 부담을 제거했습니다.

[5] ↑ Lee, K. S. Ernest (iFire) (2022-03-28). "Add fbx2gltf support for importing .fbx files". Godot. Retrieved 2023-08-21. 프로젝트 폴더에 .fbx 파일을 드래그하거나 배치할 수 있으며 파일을 가져옵니다. 편집기 설정에서 fbx2gltf 바이너리의 위치를 설정합니다.

[6] ↑ Engine, Godot. "Introducing the improved ufbx importer in Godot 4.3". Godot Engine. Retrieved 2024-08-03.

