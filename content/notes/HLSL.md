---
tags:
  - graphics
  - directX11
  - languages/hlsl
---

_High-level shader language_

---

# 개요

HLSL은 DirectX11의 프로그램 가능한 쉐이더를 짤 때 사용하는 C와 유사한 고수준 쉐이더 언어이다.

예를 들어, HLSL로 정점 쉐이더와 픽셀 쉐이더를 작성하여 DirectX3D 실행 프로그램의 렌더링 기능을 구현하는 데에 사용할 수 있다.

또는 HLSL로 컴퓨트 쉐이더를 작성하여 물리 시뮬레이션을 구현할 수도 있다.

HLSL은 프로그래밍 가능한 3차원 그래픽 파이프라인을 설정하기 위해 사용된다. HLSL을 사용해 전체 파이프라인을 구축할 수도 있다.

# Reference for HLSL

이 문단은 HLSL의 언어적 특성을 설명한다.

## Language Syntax

HLSL 쉐이더는 변수와 함수로 구성되며, 함수는 다시 구문(statement)들로 이루어진다. 이 문단은 다음의 내용을 포함한다.

1. 변수를 정의하고 선언하는 방법.
2. 쉐이더가 실행 시간에 변수에 기반한 결정을 내릴 수 있도록 하는 흐름 제어
3. 커스텀 함수 작성

### Variables

HLSL의 변수는 C 언어의 변수와 유사하다.
C와 유사하게,

1. 변수의 이름을 짓는데 제약이 존재한다.
2. 어디에서 선언되었는지에 따라 유효 범위가 달라진다.
3. 사용자 메타 데이터를 부여할 수 있다.
4. 여러 표준 자료형이 존재한다.

C와 다른 점도 존재한다. HLSL에는 3차원 그래픽 데이터를 연산하기 위해 행렬 수학을 필요로 하는 4차원 벡터의 성능을 극대화하기 위해 추가적으로 정의된 자료형들이 존재한다.

#### Variable syntax

기본적인 형식은 아래와 같다.

```text

[Storage Class][Type_Modifier] Type Name [Index][:Semantic][:Packoffset][:Register]; [Annotations][=Initial_Value]

```

##### Parameters

==Storage_Class==

선택적인 요소이며, 컴파일러에게 변수의 범위와 수명에 관한 정보를 전달하기 위해 사용한다. 이 한정자는 순서의 제한 없이 사용할 수 있다.

**extern** 

전역 변수를 쉐이더의 외부 입력으로 표시한다. 이것은 모든 전역 변수에 대한 기본값이다. static과 조합될 수 없다.

---

**nointerpolation**

정점 쉐이더의 출력값을 픽셀 쉐이더로 넘기기 전에 보간하지 않는다.

---

**precise**

이 키워드를 변수에 적용하면 해당 변수에 할당된 값을 생성하기 위해 사용되는 계산이 다음과 같은 방식으로 제한된다.

1. **연산의 분리 유지**  
예를 들어 `mul`과 `add` 연산이 하나의 `mad` 연산으로 합쳐질 수 있는 경우라도, `precise`는 이 연산들이 별도로 유지되도록 강제합니다.  
대신, `mad` 연산이 필요하다면 반드시 `mad` 내장 함수를 명시적으로 사용해야 합니다.
2. **연산 순서 보존**  
성능 향상을 위해 연산 순서가 변경될 수 있는 경우라도, `precise`는 작성된 순서를 그대로 유지하도록 컴파일러에 지시합니다.
3. **IEEE 안전하지 않은 연산 제한**  
NaN(Not a Number)과 INF(무한대) 값을 고려하지 않는 빠른 수학 연산(fast math)을 컴파일러가 사용할 수 있지만, `precise`를 사용하면 NaN과 INF 처리에 대한 IEEE 규격을 반드시 준수하도록 강제합니다.  
`precise`를 사용하지 않으면 이런 최적화와 수학 연산은 IEEE 안전성을 보장하지 않습니다.

> `precise`로 변수를 지정한다고 해서, 그 변수를 사용하는 모든 연산이 자동으로 `precise`가 되지는 않습니다.  
> `precise`는 해당 변수의 값 계산에 직접 기여하는 연산에만 전파되므로, 원하는 계산을 정확히 `precise`로 만드는 것은 까다로울 수 있습니다.  
> 따라서 셰이더 출력값이 정확해야 하는 경우, 구조체 필드, 출력 파라미터, 또는 엔트리 함수의 반환 타입에서 바로 `precise`를 선언하는 것을 권장합니다.

이렇게 최적화를 제어하면 누적된 정밀도 차이로 인해 최종 결과가 변하는 것을 방지할 수 있으며, 특히 테셀레이션 셰이더에서 **패치 경계가 완전히 일치**하도록 하거나, 여러 패스를 거쳐도 깊이 값이 일관되게 맞아야 하는 경우에 유용합니다.

**예제 코드:**

```hlsl

HLSLmatrix g_mWorldViewProjection;
void main(in float3 InPos : Position, out precise float4 OutPos : SV_Position)
{
    // OutPos에 기여하므로 연산이 precise로 처리됨
    OutPos = mul(float4(InPos, 1.0), g_mWorldViewProjection);
}

```

---

**shared** 

변수를 여러 이펙트에서 공유하도록 표시합니다. 컴파일러에 주는 힌트입니다.

**groupshared**  

변수를 Compute Shader에서 스레드 그룹 간 공유 메모리로 표시합니다.

- D3D10: `groupshared` 변수 전체 크기 제한 = 16KB
    
- D3D11: `groupshared` 변수 전체 크기 제한 = 32KB
    

---

**static**

- 로컬 변수를 한 번만 초기화하고, 함수 호출 간에 값을 유지하도록 표시합니다.
    
- 초기화식이 없으면 값은 0으로 설정됩니다.
    
- 전역 변수가 `static`이면 애플리케이션에서 접근할 수 없습니다.
    

---

**uniform**

- 셰이더 실행 동안 변하지 않는 데이터를 나타내는 변수에 사용합니다.  
    (예: 정점 셰이더의 재질 색상)
    
- 전역 변수는 기본적으로 `uniform`으로 간주됩니다.
    

---

**volatile**

- 값이 자주 바뀌는 변수에 표시합니다. 컴파일러에 주는 힌트입니다.
    
- 이 한정자는 **로컬 변수에만 적용**됩니다.
    
- **주의:** 현재 HLSL 컴파일러는 이 한정자를 무시합니다.

---
---

==Type_Modifier==

선택적인 자료형 한정자이다.

---

**const**

셰이더에서 변경할 수 없는 변수를 표시합니다. 따라서 반드시 변수 선언 시에 초기화해야 합니다.  
전역 변수는 기본적으로 `const`로 간주됩니다.  
(컴파일러에 `/Gec` 플래그를 주면 이 기본 동작을 해제할 수 있습니다.)

---

**row_major**

4개의 구성 요소를 한 행(row)에 저장하여, 이를 단일 상수 레지스터에 저장할 수 있음을 표시합니다.

---

**column_major**

4개의 구성 요소를 한 열(column)에 저장하여 행렬 연산을 최적화하도록 표시합니다.

---

>참고
>
>만약 타입 수정자(type-modifier)를 지정하지 않으면, 컴파일러는 기본값으로 `column_major`를 사용합니다.

---
---

==Type==

[Data Types (DirectX HLSL)](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-data-types)에 명시된 HLSL 자료형이다.

---
---

==Name[Index]==

셰이더 변수를 고유하게 식별하는 ASCII 문자열 이름입니다.  
선택적으로 배열을 정의할 때, `Index`는 배열 크기를 의미하며, 양의 정수이고 기본값은 1입니다.

---

==Semantic==

선택적 파라미터 사용 정보를 나타내며, 컴파일러가 셰이더 입출력을 연결하는 데 사용합니다.  
정점 셰이더와 픽셀 셰이더용으로 여러 사전 정의된 시맨틱이 있습니다.  
컴파일러는 전역 변수나 셰이더에 전달되는 파라미터에 선언된 시맨틱만 인식합니다.

---

==Packoffset==

셰이더 상수를 수동으로 패킹하기 위한 선택적 키워드입니다.  
자세한 내용은 `packoffset (DirectX HLSL)` 참고 바랍니다.

---

==Register==

셰이더 변수를 특정 레지스터에 수동 할당하기 위한 선택적 키워드입니다.  
자세한 내용은 `register (DirectX HLSL)` 참고 바랍니다.

---

==Annotation(s)==

전역 변수에 붙일 수 있는 선택적 메타데이터(문자열 형태)입니다.  
이 어노테이션은 효과 프레임워크에서 사용하며 HLSL 컴파일러는 무시합니다.  
더 자세한 문법은 `annotation syntax`를 참고하세요.

---

==Initial_Value==

선택적 초기 값들입니다. 초기 값의 개수는 변수 타입(Type)의 구성 요소 수와 일치해야 합니다.

- `extern`으로 표시된 전역 변수는 리터럴 값으로 반드시 초기화해야 합니다.
- `static`으로 표시된 변수는 상수로 초기화해야 합니다.

==전역 변수 초기화 및 컴파일 동작==

- `static` 또는 `extern`으로 표시되지 않은 전역 변수는 셰이더에 컴파일되지 않습니다.
- 컴파일러는 전역 변수에 기본값을 자동으로 설정하지 않고, 최적화에도 사용하지 않습니다.
- 이런 전역 변수를 초기화하려면, 셰이더 리플렉션(reflection)을 사용해 값을 얻고, 그 값을 상수 버퍼에 복사해야 합니다.
    

예를 들어:

1. `ID3D11ShaderReflection::GetVariableByName` 메서드로 변수를 찾고
2. `ID3D11ShaderReflectionVariable::GetDesc` 메서드로 변수 설명을 얻고
3. `D3D11_SHADER_VARIABLE_DESC` 구조체의 `DefaultValue` 멤버에서 초기 값을 얻습니다.
4. 그리고 초기값을 복사할 상수 버퍼는 CPU 쓰기 권한(`D3D11_CPU_ACCESS_WRITE`)으로 생성되어야 합니다.

상수 버퍼 생성 방법은 How to: Create a Constant Buffer 문서를 참고하세요.

==이펙트 프레임워크 사용==

이펙트 프레임워크를 사용하면 리플렉션과 초기값 설정을 자동으로 처리할 수 있습니다.  
예를 들어 `ID3DX11EffectPass::Apply` 메서드를 사용할 수 있습니다.

>**중요한 사항**
>
>이 기능(기본 초기값 리플렉션 포함)은 Direct3D 12에서 제거되었습니다.
>즉, Direct3D 12부터는 기본 초기값 리플렉션을 지원하지 않습니다.

##### Examples

다음은 쉐이더 변수 선언의 여러 예시이다.

```hlsl

float fVar;

```

```hlsl

float4 color;

int iVar[3];

uniform float4 position : SV_POSITION;

// Default initializers; supported up to Direct3D 11.

float fVar = 3.1f;
int iVar[3] = {1, 2, 3};
const float4 lightDirection = {0, 0, 1};

```

##### Group shared

HLSL은 컴퓨트 셰이더의 쓰레드들이 공유 메모리를 통해 값을 교환할 수 있게 합니다. HLSL은 `GroupMemoryBarrierWithGroupSync`와 같은 장벽 프리미티브를 제공하여 셰이더 내에서 공유 메모리의 읽기와 쓰기 순서를 올바르게 보장하고 데이터 경쟁을 방지합니다.

> **참고**  
> 하드웨어는 쓰레드를 그룹(워프 또는 웨이브프론트) 단위로 실행하며, 같은 그룹에 속한 쓰레드만 동기화하는 경우 장벽 동기화를 생략할 수 있어 성능을 높일 수 있습니다. 하지만 다음 이유들로 이 생략을 강력히 권장하지 않습니다:
> 
> - 이 생략은 비포터블한(non-portable) 코드를 만들며, 일부 하드웨어에서는 작동하지 않고 보통 더 작은 그룹 단위로 쓰레드를 실행하는 소프트웨어 래스터라이저에서는 작동하지 않습니다.
>     
> - 이 생략으로 얻는 성능 향상은 모든 쓰레드 장벽을 사용할 때보다 미미합니다.
> 
> Direct3D 10에서는 `groupshared`에 쓰기 시 쓰레드 동기화가 없으므로, 각 쓰레드는 배열 내 단일 위치에만 쓸 수 있습니다. 쓰기 시 충돌을 방지하려면 `SV_GroupIndex` 시스템 값을 이용해 배열 인덱스를 지정해야 합니다. 읽기 측면에서는 모든 쓰레드가 배열 전체에 접근할 수 있습니다.

``` hlsl

struct GSData
{
    float4 Color;
    float Factor;
}

groupshared GSData data[5*5*1];

[numthreads(5,5,1)]
void main(uint index : SV_GroupIndex)
{
    data[index].Color = (float4)0;
    data[index].Factor = 2.0f;
    GroupMemoryBarrierWithGroupSync();
    ...
}

```

---

##### Packing

레지스터 경계를 넘지 않도록 충분히 큰 크기를 가진 벡터 및 스칼라 하위 컴포넌트를 패킹합니다. 예를 들어, 다음은 모두 유효합니다:

```hlsl

cbuffer MyBuffer
{
    float4 Element1 : packoffset(c0);
    float1 Element2 : packoffset(c1);
    float1 Element3 : packoffset(c1.y);
}

```

패킹 타입을 혼합할 수 없습니다.

`register` 키워드처럼, `packoffset`도 특정 타겟에 지정할 수 있습니다. 하위 컴포넌트 패킹은 `packoffset` 키워드에서만 가능하며, `register` 키워드에서는 불가능합니다. `cbuffer` 선언 내에서 `register` 키워드는 Direct3D 10 타겟에 대해 무시되며, 이는 크로스 플랫폼 호환성을 위해서입니다.

패킹된 요소는 겹칠 수 있으며, 컴파일러는 오류나 경고를 출력하지 않습니다. 아래 예시에서 `Element2`와 `Element3`는 `Element1.x`와 `Element1.y`와 겹칩니다.

```hlsl

cbuffer MyBuffer
{
    float4 Element1 : packoffset(c0);
    float1 Element2 : packoffset(c0);
    float1 Element3 : packoffset(c0.y);
}

```

packoffset을 사용하는 예제는 HLSLWithoutFX10 Sample을 참고하세요.

### packoffset

선택적이다(필수적이지 않다).
키워드를 포장(packing)하는 쉐이더 상수이다.

다음의 문법을 사용한다.

```text

: packoffset( c[Subcomponent][.component] )

```

#### Parameters

==packoffset==

키워드를 필요로 한다.

==c==

패킹은 상수 레지스터(c)에만 적용될 수 있다.

==[Subcomponent][.component]==

선택적인 하위 구성요소(subcomponent)와 구성요소(component)이다.
하위 구성요소는 레지스터 번호이며, 정수이다. 구성요소(component)는 \[.xyzw]의 형태를 하고 있다.

변수를 선언할 때 쉐이더 상수를 수동으로 포장(pack)하고 싶으면 이 키워드를 사용한다.

상수를 포장할 때는, 상수의 타입을 섞어서 사용하면 안된다(의역 : When packing a constant, you cannot mix constant types).

컴파일러는 전역 상수(global constants)와 uniform constants에 대해 조금 다르게 동작한다.

- **global constant** : 전역 변수(global variable)는 컴파일러에 의하여 전역 상수(global constant)로서 `$Global cbuffer`에 추가된다. 자동적으로 포장된 요소는(packoffset 없이 선언되었다는 말) 마지막으로 수동으로 포장된 변수 뒤에 나타난다. 당신은 전역 상수를 포장할 때 타입을 섞어서 사용해도 된다(You may mix types when packing global constants).
- **uniform constant** : 함수의 파라미터 목록 내부의 uniform parameter는 쉐이더가 effects framework 밖에서 컴파일 될 때 컴파일러에 의하여 `$Param` 상수 버퍼에 추가된다. 효과(Effect) 프레임워크 내부에서 컴파일될 때, uniform 상수는 전역 범위에서 정의된 uniform 변수로 해석되어야 한다. uniform 상수는 수동으로 오프셋을 적용할 수 없다. 이들은 전역 변수로 다시 연결되는 셰이더의 특수화(specialization)에만 사용하는 것이 권장되며, 애플리케이션 데이터를 셰이더로 전달하는 수단으로 사용해서는 안 된다.

[여기](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-packing-rules)에 몇몇 추가적인 예시들이 있다.

#### Examples

다음은 수동으로 쉐이더 상수(shader constants)를 포장하는 여러 예제들이다.

벡터와 스칼라의 하위 구성 요소를 패킹할 때, 레지스터 경계를 넘어가지 않도록 충분히 큰 크기를 사용해야 한다. 예를 들어, 다음은 모두 유효하다.

```hlsl

cbuffer MyBuffer
{
    float4 Element1 : packoffset(c0);
    float1 Element2 : packoffset(c1);
    float1 Element3 : packoffset(c1.y);
}

```

### register

쉐이더 변수를 특정 레지스터에 지정하는 데 사용하는 키워드이며, 필수적이지 않다. 다음의 문법을 따른다.

```text

: register ( [shader_profile], Type#[subcomponent] )

```

#### Parameters

==register==

키워드가 필요하다.

==[shader_profile]==

선택적인 쉐이더 프로필이며, 쉐이더 타겟이 될 수도 있고 단순히 ps 또는 vs가 될수도 있다.

==Type#[subcomponent]==

레지스터 타입, 번호, 그리고 하위 구성요소 선언이다.
타입은 다음 중 하나이다.

- **b** : 상수 버퍼
- **t** : 텍스처와 텍스처 버퍼
- **c** : 버퍼 오프셋
- **s** : 샘플러
- **u** : unordered access view (UAV). 쉐이더가 임의의 순서로 GPU 메모리에 읽기와 쓰기를 모두 할 수 있게 해주는 뷰(View)

- \#은 레지스터 번호이며, 정수이다.
- 하위 구성요소(subcomponent)는 선택적인 정수 번호이다.

#### Remarks

공백으로 분할하여 동일한 변수 선언에 하나 혹은 그 이상의 레지스터 지정을 추가할 수 있다.

전역 스코프의 Direct3D 10 변수를 대상으로, 레지스터 키워드는 packoffset (DirectX HLSL) 키워드와 동일하게 동작한다.

#### Examples

다음에 몇몇 예시가 있다.

```hlsl

sampler myVar : register( ps_5_0, s );

```

```hlsl

sampler myVar : register( vs, s[8] );

```

```hlsl

sampler myVar : register( ps, s[2] )
              : register( ps_5_0, s[0] )
              : register( vs, s[8] );

```

### Data Types

HLSL은 많은 내부 자료형을 지원한다. 다음의 표는 쉐이더 변수를 정의할 때 사용하는 타입들을 보여준다.

| Use this intrinsic type    | To define this shader variable                          |
| -------------------------- | ------------------------------------------------------- |
| Scalar                     | 단일 요소 스칼라                                        |
| Vector, Matrix             | 다수 요소 벡터와 행렬                                   |
| Sampler, Texture or Buffer | 샘플러, 텍스처, 버퍼 객체                               |
| Struct, User Defined       | 커스텀 구조체 또는 typedef                              |
| Array                      | 대부분의 다른 타입을 포함하는 리터럴 스칼라 표현식 선언 |
| State Object               | 상태 객체의 HLSL 표현식                                 |

#### Buffer type

버퍼 변수를 선언하기 위해서는 다음의 문법을 따라야 한다.

```text

Buffer<Type> Name;

```

##### Parameters

==Buffer==

키워드를 필요로 한다.

==Type==

스칼라, 벡터, 그리고 일부 행렬 HLSL 타입 중 하나. 행렬이 4개의 32비트 값 안에 들어갈 수 있다면 버퍼 변수로 선언할 수 있다. 예를 들어 `Buffer<float2x2>`는 작성할 수 있다. 그러나 `Buffer<float4x4>`는 너무 크기 때문에 컴파일러가 오류를 발생시킨다.

==Name==

변수 이름을 지정하는 고유한 아스키 문자열이다.

##### Example

여기에 버퍼 선언의 예시가 있다.

```hlsl

Buffer<float4> g_Buffer;

```

버퍼에서 데이터를 읽을 때는, 하나의 입력 매개변수(정수 인덱스)를 받는 `Load` HLSL 내장 함수의 오버로드 버전을 사용한다. 버퍼는 요소의 배열처럼 접근되므로, 이 예제는 두 번째 요소를 읽는다.

```hlsl

float4 bufferData = g_Buffer.Load( 1 );

```

버퍼로 데이터를 출력하기 위해서는 stream-output stage를 사용한다.

##### Remarks

호환되는 타입의 buffer shader resource view( SRV )는 버퍼로부터 정확히 값을 로드하는 데 필요하다. 로드는 부분적으로 타입 변환을 수행할 수 있으며, 예를 들어 `RGBA8_UNORM` 버퍼는 `float4` 변수로 로드될 수 있다. 구조체를 담고 있는 버퍼에 대해서는 대신 StructuredBuffer를 사용한다.

#### Scalar data types

HLSL은 다음의 스칼라 자료형을 지원한다.

| data type | description                                                                                                                                                                                                                                                                             |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bool      | true 또는 false                                                                                                                                                                                                                                                                         |
| int       | 32 비트 부호가 없는 정수                                                                                                                                                                                                                                                                |
| dword     | 32 비트 부호가 없는 정수                                                                                                                                                                                                                                                                |
| half      | 16 비트 부동소수. 이 자료형은 오로지 언어의 호환성을 위해서만 제공된다. Direct3D 10 쉐이더 타깃은 모든 half 자료형을 float 자료형으로 매핑한다. half 자료형은 uniform 전역 변수에서는 사용이 불가능하다(만약 해당 기능을 사용하고 싶다면 /Gec 플래그를 사용하라).                       |
| float     | 32 비트 부동소수                                                                                                                                                                                                                                                                        |
| double    | 64 비트 부동소수. 이 자료형은 스트림의 입력 또는 출력으로 사용할 수 없다. 쉐이더 간 double 값을 전달하기 위해서, 각 double 변수를 uint 자료형의 pair로 선언한다. 그런 다음, asuint 함수를 사용하여 각 double 값을 uint의 쌍으로 패킹한 후 asdouble 함수를 사용하여 uint의 쌍을 double로 |

Windows 8부터 HLSL은 최소 정밀도(minimum precision) 스칼라 데이터 타입도 지원한다. 그래픽 드라이버는 지정된 비트 정밀도 이상인 임의의 정밀도를 사용하여 최소 정밀도 스칼라 데이터를 구현할 수 있다. 특정 하드웨어 정밀도에 의존한 클램핑(clamping)이나 래핑(wrapping) 동작에 의존하지 않는 것이 권장된다. 예를 들어, 그래픽 드라이버는 `min16float` 값을 32비트 전체 정밀도로 연산할 수도 있다.

| data type  | description                         |
| ---------- | ----------------------------------- |
| min16float | minimum 16-bit floating point value |
| min10float | minimum 10-bit floating point value |
| min16int   | minimum 16-bit signed integer.      |
| min12int   | minimum 12-bit signed integer.      |
| min16uint  | minimum 16-bit unsigned integer.    |

스칼라 리터럴에 대해 더 많은 정보를 원한다면, [Grammer](https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-appendix-grammar)를 참고하라.



