---
title: 'Microsoft .NET 6 template changes 문서 번역'
tags:
  - 'language/csharf'
  - 'platform'
  - 'translation'
---

# C# 콘솔 앱 템플릿의 최상위 문 생성

.NET 6부터 새로운 C# 콘솔 앱 프로젝트 템플릿은 Program.cs 파일에 다음 코드를 생성한다:
C#

```cs

// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");

```

이 새로운 출력은 프로그램에 필요한 코드를 간소화하는 최신 C# 기능을 사용한다. .NET 5 및 이전 버전의 경우, 콘솔 앱 템플릿은 다음 코드를 생성한다:


```cs

using System;

namespace MyApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}

```

위 코드에서 실제 네임스페이스는 프로젝트 이름에 따라 달라진다.

이 두 가지 형식은 동일한 프로그램을 나타낸다. 둘 다 C#에서 유효하다. 새로운 버전을 사용하면 Main 메서드의 본문만 작성하면 된다. 컴파일러가 진입점 메서드를 가진 Program 클래스를 생성하고 모든 최상위 문을 해당 메서드에 배치한다. 생성된 메서드의 이름은 Main이 아니며, 코드가 직접 참조할 수 없는 구현 세부 사항이다. 다른 프로그램 요소를 포함할 필요가 없으며, 컴파일러가 자동으로 생성한다. C# 가이드의 기초 섹션에 있는 최상위 문에 대한 문서에서 최상위 문을 사용할 때 컴파일러가 생성하는 코드에 대해 더 자세히 알아볼 수 있다.

.NET 6 이상 템플릿을 사용하도록 업데이트되지 않은 튜토리얼을 다루는 두 가지 방법이 있다:

- 새로운 프로그램 스타일을 사용하여 기능을 추가하면서 새로운 최상위 문을 추가한다.
- 새로운 프로그램 스타일을 Program 클래스와 Main 메서드를 가진 이전 스타일로 변환한다.

이전 템플릿을 사용하려면 이 문서의 뒷부분에 있는 "이전 프로그램 스타일 사용"을 참조한다.

# 새 프로그램 스타일 사용

새로운 프로그램을 더 간결하게 만드는 기능들은 **최상위 문**, **전역 using 지시문**, 그리고 **암시적 using 지시문**이다.

**최상위 문**은 컴파일러가 주 프로그램의 클래스와 메서드 요소를 생성한다는 것을 의미한다. 컴파일러가 생성한 클래스와 진입점 메서드는 **전역 네임스페이스**에 선언된다. 새로운 애플리케이션 코드를 보고 이전 템플릿이 생성한 `Main` 메서드 안에 있는 문장들이 전역 네임스페이스에 포함되어 있다고 상상할 수 있다.

기존 스타일의 `Main` 메서드에 문장을 추가하는 것처럼 프로그램에 더 많은 문장을 추가할 수 있다. `args`(명령줄 인수)에 접근하고, `await`를 사용하며, 종료 코드를 설정할 수도 있다. 함수를 추가하는 것도 가능한데, 이 함수들은 생성된 진입점 메서드 안에 중첩된 **지역 함수**로 만들어진다. 지역 함수는 접근 한정자(예: `public` 또는 `protected`)를 포함할 수 없다.

최상위 문과 암시적 using 지시문 모두 애플리케이션을 구성하는 코드를 간소화한다. 기존 튜토리얼을 따르려면, 템플릿이 생성한 `Program.cs` 파일에 새로운 문장들을 추가하면 된다. 튜토리얼 지침의 `Main` 메서드 안에 있는 여는 중괄호와 닫는 중괄호 사이에 작성하는 문장들이 있다고 생각할 수 있다.

만약 이전 형식을 선호한다면, 이 문서의 두 번째 예제에서 코드를 복사하여 튜토리얼을 그대로 진행할 수 있다.

최상위 문에 대한 더 자세한 내용은 최상위 문 탐색 튜토리얼에서 알아볼 수 있다.

# 암시적 using 지시문

**암시적 using 지시문**이란 컴파일러가 프로젝트 타입에 따라 자동으로 특정 `using` 지시문들을 추가하는 것을 의미한다. 콘솔 애플리케이션의 경우, 다음 지시문들이 암시적으로 포함된다:

- `using System;`
- `using System.IO;`
- `using System.Collections.Generic;`
- `using System.Linq;`
- `using System.Net.Http;`
- `using System.Threading;`
- `using System.Threading.Tasks;`

다른 애플리케이션 타입들은 해당 타입에 공통적으로 사용되는 더 많은 네임스페이스를 포함한다.

만약 암시적으로 포함되지 않은 `using` 지시문이 필요하다면, 최상위 문이 포함된 `.cs` 파일이나 다른 `.cs` 파일에 추가할 수 있다. 애플리케이션의 모든 `.cs` 파일에서 필요한 `using` 지시문이라면, **전역 using 지시문**을 사용하면 된다.

# 암시적 `using` 지시문 비활성화

이 동작을 제거하고 프로젝트의 모든 네임스페이스를 수동으로 제어하려면, 프로젝트 파일의 `<PropertyGroup>` 요소에 `<ImplicitUsings>disable</ImplicitUsings>`를 추가하면 된다.

다음 예시를 참조한다:

```XML

<Project Sdk="Microsoft.NET.Sdk"> 
	<PropertyGroup>
		... 
		<ImplicitUsings>disable</ImplicitUsings>
	</PropertyGroup>
</Project>

```

# 전역 using 지시문

전역 using 지시문은 단일 파일이 아닌 전체 애플리케이션에 네임스페이스를 가져온다. 이러한 전역 지시문은 프로젝트 파일에 \<Using> 항목을 추가하거나 코드 파일에 global using 지시문을 추가하여 적용할 수 있다.

또한, \<Using> 항목에 Remove 속성을 추가하여 특정 암시적 using 지시문을 제거할 수도 있다. 예를 들어, 암시적 using 지시문 기능이 \<ImplicitUsings>enable\</ImplicitUsings>로 켜져 있다면, 다음 \<Using> 항목을 추가하여 System.Net.Http 네임스페이스를 암시적으로 가져오는 목록에서 제거할 수 있다:

```XML

<ItemGroup>
	<Using Remove="System.Net.Http" />
</ItemGroup>

```

# 이전 프로그램 스타일 사용

.NET SDK 6.0.300부터 콘솔 템플릿에 `--use-program-main` 옵션이 생겼다. 이 옵션을 사용하면 최상위 문을 사용하지 않고 `Main` 메서드를 가진 콘솔 프로젝트를 만들 수 있다.

## .NET CLI에서 이전 스타일 사용

`dotnet new console --use-program-main` 명령어를 사용한다.

생성되는 `Program.cs` 파일은 다음과 같다:

```cs

namespace MyProject;
class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello, World!");
    }
}

```

## Visual Studio에서 이전 스타일 사용

새 프로젝트를 만들 때, "추가 정보" 설정 페이지로 이동한다. 이 페이지에서 **"최상위 문을 사용하지 않음"** 확인란을 선택한다.

프로젝트가 생성된 후 `Program.cs` 파일의 내용은 다음과 같다:

```cs

namespace MyProject;
class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello, World!");
    }
}

```

## Visual Studio에서 이전 프로그램 스타일 사용

새 프로젝트를 만들 때, 설정 단계 중 "추가 정보" 페이지로 이동한다. 이 페이지에서 "최상위 문을 사용하지 않음" 확인란을 선택한다.

이렇게 하면 Visual Studio에서 최상위 문을 사용하지 않는 방식으로 프로젝트가 생성된다. 프로젝트가 생성된 후 Program.cs 파일의 내용은 다음과 같다:

```cs

namespace MyProject;
class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello, World!");
    }
}

```

## 참고 사항

Visual Studio는 동일한 템플릿을 기반으로 다음 프로젝트를 만들 때 이 옵션의 값을 유지한다. 따라서 다음번에 콘솔 앱 프로젝트를 만들 때는 기본적으로 "최상위 문을 사용하지 않음" 확인란이 선택되어 있을 것이다. Program.cs 파일의 내용은 전역 Visual Studio 텍스트 편집기 설정이나 EditorConfig 파일에 정의된 코드 스타일에 따라 다를 수 있다.

더 자세한 정보는 "EditorConfig로 이식 가능한 사용자 지정 편집기 설정 만들기" 및 "옵션, 텍스트 편집기, C#, 고급" 문서를 참조한다.
