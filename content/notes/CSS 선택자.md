
---

#web #language/css

**

---

# 선택자란?

**CSS3 선택자**는 특정한 HTML 태그를 선택할 때 사용하는 기능이다.

선택자를 사용해 특정한 HTML 태그를 선택하면 해당 태그에 우리가 원하는 스타일 또는 기능을 적용할 수 있다.

선택자는 다음과 같이 사용된다.

```css

h1{color:read;}

```

위 예제에서 각각의 요소는

- h1 : 선택자
- color : 스타일 속성
- red : 스타일 값

에 해당한다.

이러한 코드를 **CSS 블록**이라고 부르며 **style 태그** 내부에 입력해 사용한다. 이때 style 태그 내부에 입력되는 코드를 스타일시트라고 부른다.

```html

<!--stylesheet.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS Selector Basic</title>
		<style>
			h1 {
				color: red;
				background-color: orange;
			}
		</style>
	</head>
	<body>
		<h1>CSS Selector Basic</h1>
	</body>
</html>

```

CSS3 선택자는 다양한 종류로 이루어져 있다.

# 선택자의 종류

## 전체 선택자

HTML 문서 안의 모든 태그를 선택할 때는 전체 선택자를 사용한다.

| 선택자 형태 | 설명                                     |
| ----------- | ---------------------------------------- |
| \*          | HTML 페이지 내부의 모든 태그를 선택한다. |

전체 선택자는 모든 웹 페이지에서 빠지지 않고 사용하는 선택자이다.
아래의 코드는 전체 선택자를 사용해 모든 태그의 color 속성에 red 키워드를 적용한다.

```html

<!--select_all.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			/* 모든 태그의 color 속성에 red 키워드를 적용한다. */
			* { color: red; }
		</style>
	</head>
	<body>
		<h1>Lorem ipsum</h1>
		<p>lorem ipsum dolor sit amet, consectetur adipscing elit.</p>
	</body>
</html>

```

### 전체 선택자의 범위

일반적으로 전체 선택자를 사용하면 body 태그 내부에 있는 요소에만 스타일 속성이 적용되는 것처럼 보인다. 그래서 전체 선택자가 body 태그 내부에 있는 모든 요소를 선택한다고 생각하기 쉽다.

하지만 전체 선택자를 사용하면 html 태그를 포함해 head 태그, title 태그, style 태그까지 선택한다. 다음 예제는 jQuery를 사용해 전체 선택자로 선택된 모든 태그에 스타일을 적용하는 코드이다.

```html

<!--select_all_range.html-->
<!--왜 안되는 지 모르겠다-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<script src="http://code.jquery.com/jquery-1.11.1.js"></script>
		<script>
			/* 웹페이지가 모두 준비되면 */
			$(document).ready(function () {
			/* 모든 태그의 border 속성에 Spx solid black을 적용한다 */
			$('*').css('border', 'Spx solid black');
			});
		</script>
	</head>
	<body>
		<h1>Lorem ipsum</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>


```

## 태그 선택자

태그 선택자는 HTML 페이지 내부에서 특정 종류의 태그를 모두 선택할 때 사용하는 선택자이다.

| 선택자 형태 | 설명                    |
| ----------- | ----------------------- |
| 태그        | 특정한 태그를 선택한다. |

태그 선택자는 아래의 코드처럼 사용한다. 다음 코드는 h1 태그의 color 속성에 red 키워드를 적용하고 p 태그의 color 속성에 blue 키워드를 적용한다.

```html

<!--select_tag.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Select Basic Page</title>
		<style>
			/* h1 태그의 color 속성에 red 키워드를 적용한다. */
			h1 { color: red; }

			/* p 태그의 color 속성에 blue 키워드를 적용한다. */
			p { color: blue; }
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor amet</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Nunc nisl turpis, aliquet et gravida non, facilisis a sem.</p>
	</body>
</html>

```

그리고 다음과 같이 여러 개의 선택자를 한꺼번에 선택해서 스타일 속성을 적용할 때는 쉼표를 사용한다.

여러 개의 태그 선택자를 쉼표로 연결해 margin 속성과 padding 속성을 적용한다.

```html

<style>
	body, p, h1, h2, h3, h4, h5, h6 { margin: 0; padding: 0; }
</style>

```

## 아이디 선택자

아이디 선택자는 특정한 id 속성을 가지고 있는 태그를 선택할 때 사용하는 선택자이다.

| 선택자 형태 | 설명 |
| ----------- | ---- |
| \#아이디            | 아이디 속성을 가지고 있는 태그를 선택한다.     |

웹 표준에 **id 속성은 웹 페이지 내부에서 중복되면 안된다**라는 규정이 있으므로 아이디 선택자는 특정한 하나의 태그를 선택할 때 사용한다.

일반적으로 아래의 코드처럼 공간 분할 태그에 id 속성을 적용하고 레이아웃을 구성한다.

```html

<!--select_id.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			/* id 속성값으로 header를 가지는 태그의 스타일을 지정한다. */
			#header {
				width: 800px; margin: 0 auto;
				background: red;
			}
			#wrap {
				width: 800px; margin: 0 auto;
				overflow: hidden;
			}
			#aside {
				width: 200px; float: left;
				background: blue;
			}
			#content {
				width: 600px; float: left;
				background: green;
			}
		</style>
	</head>
	<body>
		<div id="header">
			<h1>Header</h1>
		</div>
		<div id="wrap">
			<div id="aside">
				<h1>Aside</h1>
			</div>
			<div id="content">
				<h1>Content</h1>
			</div>
		</div>
	</body>
</html>

```

## 클래스 선택자

클래스 선택자는 특정한 클래스를 가지고 있는 태그를 선택할 때 사용하는 선택자이다.

| 선택자 형태 | 설명 |
| ----------- | ---- |
| .클래스      | 특정한 클래스를 가지고 있는 태그를 선택한다.     |

```html

<!--select_class.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* class 속성값으로 select를 가지는 태그의 color 속성에 red 키워드를 적용한다 */
			.select { color: red; }
		</style>
	</head>
	<body>
		<ul>
			<li class="select">Lorem ipsum</li>
			<li>Lorem ipsum</li>
			<li class="select">Lorem ipsum</li>
			<li>Lorem ipsum</li>
		</ul>
	</body>
</html>

```

### 여러 개의 클래스 선택자 사용

class 속성은 아래처럼 공백으로 구분해서 여러 클래스를 사용할 수 있다. 따라서 아래의 코드의 h1 태그는 .item, .header CSS 블록이 같이 적용된다.

```html

<h1 class="item header">Lorem ipsum</h1>

```

### 태그 선택자와 클래스 선택자

id 속성은 웹 페이지 내부에서 중복되지 않으므로 상관없지만 class 속성은 중복될 수 있다. 만약 class 속성이 서로 다른 태그에 사용된다면 태그 선택자와 클래스 선택자를 함께 사용해서 더 정확하게 클래스를 선택한다.

```html

<!--select_tag_class.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* li 태그 중 class 속성값으로 select를 가지는 태그의 color 속성을 red 키워드를 적용한다. */
			li.select { color: red; }
		</style>
	</head>
	<body>
		<h1 class="select">Lorem ipsum</h1>
		<ul>
			<li class="select">Lorem ipsum</li>
			<li>Lorem ipsum</li>
			<li>Lorem ipsum</li>
			<li>Lorem ipsum</li>
		</ul>
	</body>
</html>

```

## 속성 선택자

속성 선택자를 사용하면 특정 속성을 가진 HTML 태그를 선택할 수 있다.
속성 선택자는 지금까지 배운 다른 선택자와 함께 사용하는 선택자이다. 

속성 선택자는 기본 속성 선택자와 문자열 속성 선택자로 나눌 수 있으며 기본 속성 선택자는 많이 사용하지만 문자열 속성 선택자는 특별한 경우에만 사용한다.

### 기본 속성 선택자

기본 속성 선택자는 다음의 표와 같은 형태이다. 지금까지 배운 선택자 뒤에 대괄호([])를 사용해 속성과 값을 입력한다.

| 선택자 형태                | 설명                                                       |
| -------------------------- | ---------------------------------------------------------- |
| 선택자\[속성]              | 특정한 속성이 있는 태그를 선택한다                         |
| 선택자\[속성=값]\[속성=값] | 특정한 속성 안의 값이 특정 값과 같은 문서 객체를 선택한다. |

#### 기본 속성과 속성 선택자

input 태그는 type 속성을 입력하지 않으면 자동으로 text 속성값을 적용한다. 하지만 CSS는  HTML 태그가 기본으로 무엇을 출력하는지는 관심이 없기 때문에 코드에 명시적으로 속성값을 text라고 작성한 태그에만 스타일을 적용한다는 점에 유의하자.

### 문자열 속성 선택자

문자열 속성 선택자는 태그에 지정한 속성의 특정 문자열을 확인한다.

| 선택자 형태        | 설명                                                     |
| ------------------ | -------------------------------------------------------- |
| 선택자\[속성~=값]  | 속성 안의 값이 특정 값을 단어로 포함하는 태그를 선택한다 |
| 선택자\[속성\|=값] | 속성 안의 값이 특정 값을 단어로 포함하는 태그를 선택한다 |
| 선택자\[속성^=값]  | 속성 안의 값이 특정 값으로 시작하는 태그를 선택한다      |
| 선택자\[속성$=값]  | 속성 안의 값이 특정 값으로 끝나는 태그를 선택한다        |
| 선택자\[속성*=값]  | 속성 안의 값이 특정 값을 포함하는 태그를 선택한다        |

> 위 표를 보면 선택자\[속성~=값]과 선택자\[속성\|=값]의 설명이 같다. 하이픈(-)이 들어간 단어의 구분 방법이 다르다. 예를 들러 ko-kr 글자를 다음과 같이 인식한다.

| 선택자             | 단어 인식 |
| ------------------ | --------- |
| 선택자\[속성~=값]  | ko-kr     |
| 선택자\[속성\|=값] | ko와 kr   |

문자열 속성 선택자는 거의 사용하지 않지만 파일 형태에 따라 스타일을 적용할 때 가끔 사용한다.

```html

<!--select_string-attribute.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* img 태그 중에서 src 속성값이 png로 끝나는 태그의
			border 속성에 3px solid red를 적용한다 */
			img[src$=png] { border: 3px solid red; }

			/* img 태그 중에서 src 속성값이 jpg로 끝나는 태그의
			border 속성에 3px solid green를 적용한다 */
			img[src$=jpg] { border: 3px solid green; }

			/* img 태그 중에서 src 속성값이 gif로 끝나는 태그의
			border 속성에 3px solid blue를 적용한다 */
			img[src$=png] { border: 3px solid blue; }
		</style>
	</head>
	<body>
		<img src="jajq.png" width="200" height="250" />
		<img src="node.jpg" width="200" height="250" />
		<img src="ux.gif" width="200" height="250" />
	</body>
</html>

```

문자열 속성 선택자는 복잡한 CSS 프레임워크를 만들 때나 사용하는 선택자이므로, 나중에 정말 필요한 경우에만 찾아봐도 늦지 않다.

## 후손 선택자

후손 선택자는 특정한 태그 아래에 있는 [[HTML 태그, 요소 그리고 속성#^b1cf89| 후손]]을 선택할 때 사용하는 선택자이다.

| 선택자 형태     | 설명                                         |
| --------------- | -------------------------------------------- |
| 선택자A 선택자B | 선택자A의 후손에 위치하는 선택자B를 선택한다 |

```html

<!--select_grandchild.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* id 속성값으로 header를 가지는 태그의 후손 위치에 있는 h1 태그의
			   color 속성에 red 키워드를 적용한다. */
			#header h1 { color: red; }
			/* id 속성값으로 section를 가지는 태그의 후손 위치에 있는 h1 태그의
			   color 속성에 orange 키워드를 적용한다. */
			#section h1 { color: orange; }
		</style>
	</head>
	<body>
		<div id="header">
			<h1 class="title">Lorem ipsum</h1>
			<div id="nav">
				<h1>Navigation</h1>
			</div>
		</div>
		<div id="section">
			<h1 class="title">Lorem ipsum</h1>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		</div>
	</body>
</html>

```

### 후손 선택자와 관련된 주의 사항

여러 개의 선택자를 함께 사용할 때 후손 선택자를 다음과 같이 사용하는 경우가 있다.

```html

<style>
	/* id 속성값이 header인 태그의 후손 위치에 있는 h1 태그와 h2 태그의 color 속성에 red 키워드를 적용한다. */
	#header h1, h2 {color: red; }
</style>

```

위 예제의 선택자는 \#header 태그의 후손에 위치하는 h1 태그를 선택하고 일반적인 h2 태그를 선택한다.
만약 \#header 태그의 후손에 위치하는 h1 태그와 \#header 태그의 후손에 위치하는 h2 태그를 선택하고 싶다면 아래의 코드처럼 사용해야 한다.

```html

<style>
	/* id 속성값이 header인 태그의 후손 위치에 있는 h1 태그와
	   id 속성값이 header인 태그의 후손 위치에 있는 h2 태그의
	   color 속성에 red 키워드를 적용한다. */
	#header h1, #header h2 { color: red; }
<\style>

```

## 자손 선택자

자손 선택자는 특정 태그 아래에 있는 [[HTML 태그, 요소 그리고 속성#^b1cf89 | 자손]]을 선택할 때 사용하는 선택자이다.

| 선택자 형태       | 설명 |
| ----------------- | ---- |
| 선택자A > 선택자B | 선택자A의 자손에 위치하는 선택자B를 선택한다.     |

아래의 예제는 위에서 살펴본 body 태그와 구성이 같지만 \#nav 태그 아래에 있는 h1 태그에는 스타일이 적용되지 않는다.

```html

<!--select_child.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* id 속성값으로 header를 가지는 태그의 후손 위치에 있는 h1 태그의
			   color 속성에 red 키워드를 적용한다. */
			#header > h1 { color: red; }
			/* id 속성값으로 section를 가지는 태그의 후손 위치에 있는 h1 태그의
			   color 속성에 orange 키워드를 적용한다. */
			#section > h1 { color: orange; }
		</style>
	</head>
	<body>
		<div id="header">
			<h1 class="title">Lorem ipsum</h1>
			<div id="nav">
				<h1>Navigation</h1>
			</div>
		</div>
		<div id="section">
			<h1 class="title">Lorem ipsum</h1>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		</div>
	</body>
</html>

```

### table 태그와 자손 선택자 주의 사항

table 태그의 요소를 선택할 때는 자손 선택자를 사용하는 것이 좋지 않다.

```html

<!--select_child_with_table.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* table 태그 아래의 tr 태그 아래 th 태그의 color 속성에 red 키워드를 적용한다. */
			table > tr > th {
				color: red;
			}
		</style>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>Name</th>
				<th>Region</th>
			</tr>
			<tr>
				<td>윤인성</td>
				<td>서울특별시 강서구 내발산동</td>
			</tr>
		</table>
	</body>
</html>

```

대부분 th 태그에 빨간색이 적용되는 것을 예상할 것이다. 하지만 실제로는 스타일 속성이 적용되지 않는다.

이 문제는 요소 검사를 사용해 HTML 페이지의 계층 구조를 살펴보면 원인을 알 수 있다. table 태그에 tbody 태그가 자동으로 추가되어 있을 것이다. 이렇게 웹 브라우저가 자동으로 tbody 태그를 추가하므로 스타일 속성이 적용되지 않는 것이다.

따라서 `table > tbody > tr > th` 선택자를 사용해야 색상을 적용할 수 있다. 소스 코드와 실행 결과가 달라 혼동되므로 table 선택자에 스타일을 적용할 때는 자손 선택자를 사용하지 않도록 하자.

## 동위 선택자

[[HTML 태그, 요소 그리고 속성#^a63bb2 | 동위]] 선택자는 동위 관계에서 뒤에 위치한 태그를 선택할 때 사용하는 선택자이다.

| 선택자 형태       | 설명                                           |
| ----------------- | ---------------------------------------------- |
| 선택자A + 선택자B | 선택자A 바로 뒤에 위치하는 선택자B를 선택한다. |
| 선택자A ~ 선택자B | 선택자A 뒤에 위치하는 모든 선택자B를 선택한다.      |

```html

<!--select_brother.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* h1 태그 바로 뒤에 위치하는 h2 태그의 color 속성에 red 키워드를 적용한다. */
			h1 + h2 { color: red; }
			/* h1 태그 뒤에 위치하는 h2 태그의 background-color 속성에 orange 키워드를 적용한다. */
			h1 ~ h2 { background-color: orange; }
		</style>
	</head>
	<body>
		<h1>Header - 1</h1>
		<h2>Header - 2</h2>
		<h2>Header - 2</h2>
		<h2>Header - 2</h2>
		<h2>Header - 2</h2>
	</body>
</html>

```

동위 선택자는 CSS3 애니메이션을 사용해 동적으로 움직이는 레이아웃을 구성할 때 사용된다.

## 반응 선택자

반응 선택자는 사용자의 반응으로 생성되는 특정한 상태를 선택하는 선택자이다. 사용자가 마우스를 특정한 태그 위에 올리면 hover 상태가 적용되고 클릭하면 active 상태가 적용된다.

| 선택자 형태 | 설명                                      |
| ----------- | ----------------------------------------- |
| :active     | 사용자가 마우스로 클릭한 태그를 선택한다. |
| :hover      | 사용자가 마우스를 올린 태그를 선택한다.   |

```html

<!--select_reactor.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* h1 태그에 마우스를 올릴 경우에
			   color 속성에 red 키워드를 적용한다. */
			h1:hover { color: red; }
			/* h1 태그를 마우스로 클릭할 때
			   color 속성에 blue 키워드를 적용한다. */
			h1:active { color: blue; }
		</style>
	</head>
	<body>
		<h1>User Action Selector</h1>
	</body>
</html>

```

## 상태 선택자

상태 선택자는 입력 양식의 상태를 선택할 때 사용하는 선택자이다.

| 선택자 형태 | 설명                                   |
| ----------- | -------------------------------------- |
| :checked    | 체크 상태의 input 태그를 선택한다.     |
| :focus      | 초점이 맞추어진 input 태그를 선택한다. |
| :enabled    | 사용 가능한 input 태그를 선택한다.     |
| :disabled   | 사용 불가능한 input 태그를 선택한다.   |

상태에 관해 좀 더 부연해보도록 하겠다.

checked 상태는 type 속성값이 checkbox 또는 radio인 input 태그가 선택된 상태를 의미한다.

focus 상태는 사용자가 초점을 맞추고 있는 입력 양식에 적용되는 상태이다. 참고로 웹페이지 하나당 하나의 input 태그에만 초점을 맞출 수 있다.

마지막으로 enabled 상태는 input 태그가 사용 가능한 상태를 나타내고 disabled 상태는 input 태그가 사용 불가능한 상태를 나타낸다.

```html

<!--select_status.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* input 태그가 사용 가능할 경우에
			   background_color 속성에 white 키워드를 적용한다 */
			input:enabled { background-color: white; }
			/* input 태그가 사용 가능할 경우에
			   background_color 속성에 white 키워드를 적용한다 */
			input:disabled { background-color: gray; }
			/* input 태그가 사용 가능할 경우에
			   background_color 속성에 white 키워드를 적용한다 */
			input:focus { background-color: orange; }
		</style>
	</head>
	<body>
		<h2>Enabled</h2>
		<input />
		<h2>Disabled</h2>
		<input disabled="disabled" />
	</body>
</html>

```

아래 예제는 상태 선택자를 복합적으로 적용시킨 예이다.

```html

<!--select_status_brother.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* input 태그의 type 속성값이 checkbox인 태그가 체크되었을 때
			   바로 뒤에 위치하는 div 태그의 height 속성에 0픽셀을 적용한다 */
			input[type=checkout]:checked + div {
				height: 0px;
			}
			div {
				overflow: hidden;
				width: 650px; height: 300px;

				/* 변환 효과를 적용한다 */
				-ms-transition-duration: 1s;
				-webkit-transition-duration: 1s;
				-moz-transition-duration: 1s;
				-o-transition-duration: 1s;
				transition-duration: 1s;
			}
		</style>
	</head>
	<body>
		<input type="checkbox" />
		<div>
			<h1>Lorem ipsum</h1>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		</div>
	</body>
</html>

```

## 구조 선택자

구조 선택자는 CSS3부터 지원하는 선택자이다. 일반적으로 자손 선택자와 병행해서 많이 사용한다.

### 일반 구조 선택자

일반 구조 선택자는 특정한 위치에 있는 태그를 선택하는 선택자이다.

| 선택자 형태           | 설명                                                 |
| --------------------- | ---------------------------------------------------- |
| :first-child          | 형제 관계 중에서 첫 번째에 위치하는 태그를 선택한다. |
| :last-child           | 형제 관계 중에서 마지막에 위치하는 태그를 선택한다.  |
| :nth-child(수열)      | 형제 관계 중에서 앞에서 수열 번째에 태그를 선택한다. |
| :nth-last-child(수열) | 형제 관계 중에서 뒤에서 수열 번째에 태그를 선택한다.                                                     |

nth-child 선택자와 nth-last-child 선택자의 괄호 안에 수열을 넣으라는 말이 모호해보인다. 간단하게 다음 수열을 예시로 들어보겠다.

`2n + 1`

위 수열에 0부터 숫자를 하나씩 넣어보면 다음과 같은 수의 나열을 얻을 수 있다.

`1, 3, 5, 7, 9 ...`

따라서  `:nth-child(2n+1)` 선택자를 사용하면 첫 번째, 세 번째, 다섯 번째 등에 위치하는 태그를 선택한다.

## 형태 구조 선택자

형태 구조 선택자는 일반 구조 선택자와 비슷하지만 태그 형태를 구분한다.

| 선택자 형태             | 설명                                                               |
| ----------------------- | ------------------------------------------------------------------ |
| :first-of-type          | 형제 관계 중에서 첫 번째로 등장하는 특정 태그를 선택한다.          |
| :last-of-type           | 형제 관계 중에서 마지막으로 등장하는 특정 태그를 선택한다.         |
| :nth-of-type(수열)      | 형제 관계 중에서 앞에서 수열 번째로 등장하는 특정 태그를 선택한다. |
| :nth-last-of-type(수열) | 형제 관계 중에서 뒤에서 수열 번째로 등장하는 특정 태그를 선택한다. |

```html

<!--select_brother_struct.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			h1:first-of-type {color:red;}
			h2:first-of-type {color:red;}
			h3:first-of-type {color:red;}
		</style>
	</head>
	<body>
		<h1>Header - 1</h1>
		<h2>Header - 2</h2>
		<h3>Header - 3</h3>
		<h3>Header - 3</h3>
		<h2>Header - 2</h2>
		<h1>Header - 1</h1>
	</body>
</html>

```

```html

<!--select_brother_struct2.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			body > *:first-of-type {color:red;}
		</style>
	</head>
	<body>
		<h1>Header - 1</h1>
		<h2>Header - 2</h2>
		<h3>Header - 3</h3>
		<h4>Header - 4</h4>
		<h5>Header - 5</h5>
		<h6>Header - 6</h6>
	</body>
</html>

```

## 문자 선택자

문자 가상 요소 선택자는 태그 내부 특정 조건의 문자를 선택하는 선택자이다. 문자 선택자는 가상 요소 선택자 Pseudo-Element Selector로 ::기호를 사용하는 것이 표준이지만 : 기호를 사용해도 정상 작동한다. 하지만 이 문서에서는 표준에 맞게 :: 기호를 사용한다.

### 시작 문자 선택자

시작 문자 선택자는 태그 내부의 첫 번째 글자와 첫 번째 줄을 선택할 때 사용하는 선택자이다.

| 선택자 형태    | 설명                    |
| -------------- | ----------------------- |
| ::first-letter | 첫 번째 글자를 선택한다 |
| ::first-line   | 첫 번째 줄을 선택한다   |

### 전후 문자 선택자

전후 문자 선택자는 특정 태그의 전후에 위치하는 공간을 선택하는 선택자이다.

| 선택자 형태 | 설명                               |
| ----------- | ---------------------------------- |
| ::after     | 태그 뒤에 위치하는 공간을 선택한다 |
| ::before    | 태그 앞에 위치하는 공간을 선택한다 |

전후 문자 선택자에는 **content 속성**을 사용할 수 있다(다른 선택자에는 content 속성을 사용할 수 없다).

```html

<!--select_front_back.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			p { counter-increment: rint; }
			p::before { content: counter(rint) "."; }
			p::after { content: " - " attr(data-page) " page"; }
			p::first-letter { font-size: 3em; }
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor sit amet</h1>
		<p data-page="52">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p data-page="273">Aenean ac erat et massa vehicula laoreet consequat et sem.</p>
	</body>
</html>

```

주의 깊게 살펴볼 부분은 `::first-letter` 선택자를 사용해 첫 번째 글자를 선택했을 때 전후 문자 선택자로 생성한 글자도 스타일이 적용된다는 것이다.

###  data 속성

웹 표준에 따르면 각각의 태그에 지정된 속성 의외의 것을 사용하면 안된다. 하지만 속성 앞에 문자열 data-를 붙이면 사용자 지정 속성으로 인정해준다.

위의 select_front_back.html 예제에서는 특정한 정보를 넣기 위해 사용자 지정 속성인 data-page 속성을 사용한다. 실제로 data-page 속성은 웹 표준에 존재하지 않고 임의로 지정한 것이다.

웹과 관련된 기술을 접할수록 사용자 지정 속성은 굉장히 많이 사용된다. 아래 예제는 모바일 애플리케이션을 쉽게 만들 수 있게 도와주는 jQuery Mobile 프레임워크를 사용한 코드이다. jQuery Mobile 프레임워크는 div 태그에 data-role 속성을 사용하면 레이아웃을 자동으로 구성해준다.

```html

<!--jQuery_Mobile.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>--jQuery_Mobile</title>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet"
		href="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.css" />
		<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.4.4/jquery.mobile-1.4.4.min.js"></script>
	</head>
	<body>
		<div data-role="page">
			<div data-role="header" data-theme="b">
				<h1>HTML5</h1>
			</div>
			<div data-role="content">
				<ul data-role="listview">
					<li data-role="list-divider">HTML5</li>
					<li>Multimedia</li>
					<li>Connectivity</li>
					<li>Device Access</li>
					<li data-role="list-divider">CSS3</li>
					<li>Animation</li>
					<li>3d Transform</li>
				</ul>
			</div>
		</div>
	</body>
</html>

```

위 예제를 실행하면 페이지가 자동으로 디자인되는 것을 볼 수 있다. 이런 프레임워크를 UI 프레임워크라고 하며 사용자 지정 속성을 굉장히 많이 활용한다.

## 반응 문자 선택자

반응 문자 선택자는 사용자가 문자와 반응해서 생기는 영역을 선택자이다.

| 선택자 형태 | 설명                              |
| ----------- | --------------------------------- |
| ::selection | 사용자가 드래그한 글자를 선택한다 |

```html

<!--select_reacting_string.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			p::selection { background: black; color: red;}
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor sit amet</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Nunc nisl turpis, aliquet et gravida non, facilisis a sem.</p>
	</body>
</html>

```

## 링크 선택자

링크 선택자는 href 속성을 가지고 있는 a 태그에 적용되는 선택자이다. 인터넷에서 한 번 다녀온 링크는 색이 변경되는 것을 볼 수 있는데, 링크 선택자는 한번 이상 다녀온 링크를 선택할 수 있는 선택자이다.

| 선택자 형태 | 설명                                          |
| ----------- | --------------------------------------------- |
| :link       | href 속성을 가지고 있는 a 태그를 선택한다     |
| :visited    | 방문했던 링크를 가지고 있는 a 태그를 선택한다 |

아래 예제는 링크 선택자와 문자 선택자를 함께 사용해 href 속성이 적용된 a 태크와 방문된 a 태그에 스타일을 적용한다.

```html

<!--select_link.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			a { text-decoration: none; }
			a:visited { color: red; }

			/* href 속성을 가지고 있는 a 태그 뒤의 공간에
			"- (href 속성)"을 추가한다 */
			a:link::after { content: ' - ' attr(href); }
		</style>
	</head>
	<body>
		<h1><a>Nothing</a></h1>
		<h1><a href="http://hanbit.co.kr">Hanbit Media</a></h1>
		<h1><a href="http://www.w3.org/">W3C</a></h1>
		<h1><a href="https://github.com/">Github</a></h1>
	</body>
</html>

```

##  부정 선택자

부정 선택자는 지금까지 배운 선택자를 모두 반대로 적용할 수 있게 만드는 선택자이다.

| 선택자 형태  | 설명                     |
| ------------ | ------------------------ |
| :not(선택자) | 선택자를 반대로 적용한다 |

```html

<!--select_not.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic</title>
		<style>
			/* input 태그 중에서 type 속성값이 password가 아닌 태그의
			   background 속성에 red 키워드를 적용한다 */
			input:not([type=password]) {
				background: red;
			}
		</style>
	</head>
	<body>
		<input type="password" />
		<input type="text" />
		<input type="password" />
		<input type="text" />
	</body>
</html>

```

---

참고자료

#참고도서/모던_웹_디자인을_위한_HTML5_CSS3_입문 

---
