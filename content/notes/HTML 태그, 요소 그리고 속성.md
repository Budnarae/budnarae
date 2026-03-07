---
title: 'HTML 태그, 요소 그리고 속성'
tags:
  - 'web'
  - 'language/html'
---

# 태그와 요소

[[HTML | HTML5]] 페이지는 사용자에게 보이는 뷰와 사용자에게 보이지 않는 코드로 나누어진다.
지금부터 살펴볼 HTML 태그는 사용자에게 보이는 뷰를 만들 때 사용한다.

태그는 HTML 페이지에서 **객체**를 만들 때 사용한다. 그리고 태그를 사용해 만들어진 객체를 **요소 Element**라고 부른다.

```html

<h1>Hello TML5</h1>

```

HTML5은 위와 같이 시작 태그와 끝 태그를 별도로 입력하는 요소도 있지만 아래와 같이 시작 태그와 끝 태그를 함께 입력하는 요소도 존재한다.
이렇게 단독으로 사용하는 태그는 **HTML5 표기법**과 **XHTML5 표기법**을 사용해 입력한다.

왼쪽이 HTML5, 오른쪽이 XHTML5 표기법이다.

```html

<br><br/>

```

어떠한 표기법을 사용해도 상관없지만 대부분의 개발자는 XHTML5 방법을 선호한다.

일부 태그는 태그 내부에 다른 태그를 넣을 수도 있다.

```html

<article>
	<h1>Article Header</h1>
	<p>Lorem ipsum dolor sit amet.</p>
</article>

```

## 후손과  자손

^b1cf89

상술했듯이, 일부 태그는 다른 태그 내부에 위치할수도 있다. 이 때, 어떤 태그의 한 단계 아래에 위치한 태그를 **자손**이라고 하고, 어떤 태그 하위에 위치한 모든 태그를 **후손**이라고 부른다.

```html

<!--child_grandchild.html-->

<!DOCTYPE html>

<html>
	<head><title>chile, grandchild</title></head>]
	<body>
		<div>
			<h1>CSS3 Selector Basic</h1>
			<h2>Lorem ipsum</h2>
			<ul>
				<li>universal selector</li>
				<li>type selector</li>
				<li>id & class selector</li>
			</ul>
		</div>
	</body>
</html>

```

## 동위

^a63bb2

태그들이 같은 깊이에 위치할 경우 이를 **동위** 관계에 있다고 한다. 예를 들어, 아래의 코드에서 \<li> 태그들은 모두 서로 동위 관계에 있다.

```html

<body>
	<ul>
		<li>CSS3 Selector Basic</li>
		<li>CSS3 Selector Basic</li>
		<li>CSS3 Selector Basic</li>
		<li>CSS3 Selector Basic</li>
		<li>CSS3 Selector Basic</li>
	</ul>
</body>

```

# 속성

태그에 추가 정보를 부여할 때는 속성을 사용한다.

아래의 예시에서 title이 **속성 이름**, header가 **속성 값**, 그리고 이 둘을 통틀어서 **속성 블록**이라 한다.
Hello HTML5는 **내부 문자**라고 한다.

```html

<h1 title="header">Hello HTML5</h1>

```

내부 문자를 갖지 않는 태그도 아래와 같이 속성을 사용할 수 있다.

```html

<img src="image.png"/>

```

# 태그 목록

## \<!DOCTYPE html> 태그

```html

<!DOCTYPE html>

```

모든 HTML 페이지의 첫 줄에 오는 태그이다. 웹 브라우저가 현재 웹 페이지가 HTML5 문서임을 인식하게 만들어준다.

W3C의 HTML5 명세에 따르면 모든 HTMl5 문서는 반드시 이 태그를 표기해야 한다.
또한 반드시 문서의 가장 첫 번째 줄에 있어야 한다.

## html 태그

모든 HTML 페이지의 **루트 요소**이다.
모든 HTML 페이지는 html 태그 내부에 작성할 수 있다.
html 태그에는 lang 속성을 입력할 수 있다.

```html

<html lang="ko">

```

lang 속성에는 다음과 같은 속성 값이 올 수 있다.

| 국가     | 속성값 |
| -------- | ------ |
| 한국     | ko     |
| 일본     | ja     |
| 중국     | zh     |
| 미국     | en     |
| 러시아어 | ru     |
| 독일어   | de       |

lang 속성은 실제 웹 브라우저가 동작하는 데 어떠한 영향도 끼치지 않는다. 대신 구글과 같은 검색 엔진이 웹 페이지를 탐색할 때 해당 웹 페이지가 어떤 언어로 만들어져 있는지 쉽게 인식하게 만든다.

전 세게적인 데이터 네트워크 구축을 위해서는 lang 속성을 입력하는 것이 좋다.

## head와 body 태그

body 태그는 사용자에게 보여지는 실제 부분이며, head 태그는 body 태그에서 필요한 스타일시트와 자바스크립트를 제공하는 데 사용한다.

### head 태그

head 태그 내부에는 다음 태그만 입력할 수 있다. 아래의 표 이외의 태그를 넣으면 웹 브라우저가 자동으로 해당 태그를 body 태그 내부로 옮긴다.

| 태그 이름 | 설명                              |
| --------- | --------------------------------- |
| meta      | 웹 페이지에 추가 정보를 전달한다  |
| title     | 웹 페이지의 제목                  |
| script    | 웹 페이지에 스크립트를 추가한다   |
| link      | 웹 페이지에 다른 파일을 추가한다  |
| style     | 웹 페이지에 스타일시트를 추가한다 |
| base      | 웹 페이지의 기본 경로를 지정한다.                                  |

## 글자 태그

### 제목 태그 - h 시리즈

HTML5의 대표적인 글자 태그는 제목을 입력할 때 사용하는 제목 글자 태그이다.
HTML5는 **h1 ~ h6**까지의 제목 글자 태그를 제공한다. h 뒤의 숫자는 글자의 크기 및 우선 순위를 나타낸다.

```html

<!--header.html-->

<!DOCTYPE html>
<html>
<head>
	<title>HTML5 + CSS3 TEXT</title>
</head>
<body>
	<h1>Header 1</h1>
	<h2>Header 2</h2>
	<h3>Header 3</h3>
	<h4>Header 4</h4>
	<h5>Header 5</h5>
	<h6>Header 6</h6>
</body>
</html>

```

### 단락 태그 - p

p 태그는 paragraph의 줄임말이다. paragraph는 단락을 의미하므로 p 태그를 사용하면 하나의 단락을 만들 수 있다.

```html

<!--paragraph.html-->

<!DOCTYPE html>
<html>
<head>
	<title>HTML TEXT Basic Page</title>
</head>
<body>
	<h1>Lorem ipsum</h1>
	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	<p>Nam commodo mi a lorem congue id rutrum leo venenatis.</p>
</body>
</html>

```

### 개행 태그 - br

`<br />`와 같이 사용한다. 줄바꿈을 적용한다.

### 수평 줄 태그 - hr

`<hr />`과 같이 사용한다. 수평 줄을 그린다.

```html

<!--paragraph.html-->

<!DOCTYPE html>
<html>
<head>
<title>HTML TEXT Basic Page</title>
</head>
<body>
	<h1>Lorem ipsum</h1>
	<h2>dodor sit amet</h2>
	<hr />
	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	<br />
	<p>Nam commodo mi a lorem congue id rutrum leo venenatis.</p>
</body>
</html>

```

## 앵커 태그 - a

앵커 anchor 태그는 서로 다른 웹 페이지 사이를 이동하거나 웹 페이지 내부에서 특정한 위치로 이동할 때 사용되는 태그이다.

**href** 속성을 사용하여 이동하고자 하는 웹페이지를 정확히 지정해야 제대로 작동한다.

```html

<!--anchor.html-->

<!DOCTYPE html>
<html>
<head>
	<title>HTML TEXT BASIC PAGE</title>
</head>
<body>
	<a href="http://hanbit.co.kr">Hanbit</a><br />
	<a href="https://github.com/">GitHub</a><br />
</body>
</html>

```

### 빈 링크

a 태그는 본래 가지고 있는 하이퍼링크 기능을 제거하고 사용하는 경우도 있다. 하지만 하이퍼링크 기능을 제거해도 웹 표준을 따르려면 a 태그에 href 속성을 반드시 입력해야 한다. 따라서 웹 표준을 지키면서 이동하지 않는 a 태그를 만들 때는 href속성에 \#을 입력한다. 그리고 이를 빈 링크라고 부른다.

```html

<a href="#">Empty link</a>

```

### 페이지 내부 이동

a 태그를 이용하면 현재 페이지 내부에서 원하는 장소로 이동할 수 있다. 이때는 원하는 장소에 id 속성을 부여해야 한다. 코드 2-8처럼 이동하기를 원하는 태그에 id 속성을 부여하고 a 태그의 href 속성에 **\#아이디** 형태의 문자열을 입력한다.

```html

<!--id.html-->

<!DOCTYPE html>
<html>
<head>id.html</head>
<body>
	<a href="#alpha">Move to Alpha</a>
	<a href="#beta">Move tot Beta</a>
	<a href="#gamma">Move to Gamma</a>
	<hr />
	<h1 id="alpha">Alpha</h1>
	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	<h1 id="beta">Beta</h1>
	<h1 id="gamma">Gamma</h1>
	<p>Nullam porta, felis sit amet porttitor vestibulum.</p>
</body>
</html>

```

id 속성이 중복되면 먼저 나오는 태그로 이동한다. 하지만 id 속성을 중복해서 사용하는 것은 웹 표준에 어긋나는 행위이므로 지양해야 한다.

## 글자 형태

HTML5는 글자 형태 태그를 사용해 웹페이지의 글자와 형태에 의미를 부여한다. 각 글자에 형태 및 의미를 부여할 때는 아래의 표이 태그들을 사용한다.

| 태그 이름 | 설명                         |
| --------- | ---------------------------- |
| b         | 굶은 글자 태그               |
| i         | 기울어진 글자 태그           |
| small     | 작은 글자 태그               |
| sub       | 아래에 달라 붙는 글자 태그   |
| sup       | 위에 달라 붙는 글자 태그     |
| ins       | 밑줄 글자 태그               |
| del       | 가운데 줄이 그어진 글자 태그 |

```html

<!--letter_type.html-->

<!DOCTYPE html>
<html>
<head>
	<title>HTML TXT Basic Page</title>
</head>
<body>
	<h1><b>Lorem ipsum dolor sit amet</b></h1>
	<h1><i>Lorem ipsum dolar sit amet</i></h1>
	<h1><small>Lorem ipsum dolar sit amet</small></h1>
	<h1><sub>Lorem ipsum dolar sit amet</sub></h1>
	<h1><sup>Lorem ipsum dolar sit amet</sup></h1>
	<h1><ins>Lorem ipsum dolar sit amet</ins></h1>
	<h1><del>Lorem ipsum dolar sit amet</del></h1>
	<hr />
	<b>Lorem ipsum dolor sit amet</b><br />
	<i>Lorem ipsum dolor sit amet</i><br />
	<small>Lorem ipsum dolor sit amet</small><br />
	<sub>Lorem ipsum dolor sit amet</sub><br />
	<sup>Lorem ipsum dolor sit amet</sup><br />
	<ins>Lorem ipsum dolor sit amet</ins><br />
	<del>Lorem ipsum dolor sit amet</del><br />
</body>
</html>

```

과거에는 이 절의 태그를 많이 사용하였다. 하지만 글자를 기울이거나 굵게 만드는 기능은 모두 스타일시트로 처리하므로 현대에는 잘 사용하지 않는다.

## 루비 문자

(생략)

## 목록 태그

대부분의 웹페이지에서 자주 사용되는 기능 중 하나는 메뉴 기능이다. 일반적으로 페이지를 이동할 때 사용되는 메뉴를 **내비게이션 메뉴**라고 한다.

내비게이션 메뉴를 만들 때는 아래의 목록 태그들을 활용한다.

| 태그 이름 | 설명                  |
| --------- | --------------------- |
| ul        | 순서가 없는 목록 태그 |
| ol        | 순서가 있는 목록 태그 |
| li        | 목록 요소             |

ol 태그는 **정렬된 목록 ordered list**를 의미하고
ul 태그는 **정렬되지 않은 목록 unordered list**를 의미한다.
li 태그는 **목록 요소 list item**를 의미한다.

```html

<!--basic_list.html-->

<!DOCTYPE html>
<html>
<head>HTML Basic Page</head>
<body>
	<h1>ol tag</h1>
	<ol>
		<li>Facebook></li>
		<li>Tweeter></li>
		<li>Linked In</li>
	</ol>
	<h1>ul tag</h1>
	<ul>
		<li>Facebook</li>
		<li>Tweeter></li>
		<li>Linked in</li>
	</ul>
</body>
</html>

```

### 중첩 목록

중첩해서 목록을 만들고 싶을 때는 li 태그 안에 목록 태그를 중첩해서 입력한다.

```html

<!--list_in_list.html-->

<!DOCTYPE html>
<html>
	<body>
	<ul>
		<li>HTML5
			<ol>
				<li>Multimedia Tag</li>
				<li>Connectivity</li>
				<li>Device Access</li>
			</ol>
		</li>
		<li>CSS3
			<ul>
				<li>Animation</li>
				<li>3D Transform</li>
			</ul>
		</li>
	</ul>
	</body>
</html>

```

## 테이블 태그

**table** 태그는 HTML 페이지에서 표를 만들 때 사용하는 태그이다. 과거에는 테이블 태그를 사용해 레이아웃을 구성하였다. 하지만 현대 웹 페이지의 대부분은 후술할 div 태그를 사용해 레이아웃을 구성하므로 사용 빈도가 굉장히 줄었다.

table 태그 안에 입력할 수 있는 태그는 많지만 실제로 많이 쓰이는 태그는 아래의 태그들이다.

| 태그 이름 | 설명                   |
| --------- | ---------------------- |
| tr        | 표 내부의 행 태그      |
| th        | 행 내부의 제목 셀 태그 |
| td        | 행 내부의 일반 셀 태그 |

```html

<!--table.html-->

<!DOCTYPE html>
<html>
	<head>HTML Basic Page</head>
	<body>
		<table border="1">
			<tr>
				<th>Header 1</th>
				<th>Header 2</th>
			</tr>
			<tr>
				<td>Data 1</td>
				<td>Data 1</td>
			</tr>
			<tr>
				<td>Data 2</td>
				<td>Data 2</td>
			</tr>
	</body>
</html>

```

table이 가질 수 있는 속성

| 속성 이름 | 설명 |
| --------- | ---- |
| border    | 표의 테두리 구께를 지정     |

th, td 태그가 가질 수 있는 속성

| 속성 이름 | 설명           |
| --------- | -------------- |
| rowspac   | 셀의 높이 지정 |
| colspan   | 셀의 너비 지정 |

```html

<!--table_attribute.html-->

<!DOCTYPE html>
<html>
	<head>HTML Basic Page</head>
	<body>
		<table border="5">
			<tr>
				<th colspan="3">Table Data</th>
				<th rowspan="3">Table Data</th>
			</tr>
			<tr>
				<td>Table Data</td>
				<td rowspan="2">imsTable Data</td>
				<td>Table Data</td>
			</tr>
			<tr>
				<td>Table Data</td>
				<td>Table Data</td>
			</tr>
		</table>
	</body>
</html>

```

## 이미지 태그

이미지를 올리기 위해서는 `<img />` 태그를 사용한다.

img 태그에서 가장 중요한 속성은 아래의 4가지 속성이다.

| 속성 이름 | 설명                              |
| --------- | --------------------------------- |
| src       | 이미지의 경로 지정                |
| alt       | 이미지가 없을 때 나오는 글자 지정 |
| width     | 이미지의 너비 지정                |
| height    | 이미지의 높이 지정                |

```html

<!--img.html-->

<!DOCTYPE html>
<html>
	<head>BASIC HTML Page</head>
	<body>
		<br />
		<img src="images.jpeg" alt="netcat" width="300" />
		<img src="Nothing" alt="그림이 존재하지 않습니다." width="300" /><br />
	</body>
</html>

```

## 오디오 태그

오디오를 올리기 위해서는  `<audio />` 태그를 사용한다.

아래의 속성들을 사용하여 구체적인 동작을 지정한다.

| 속성 이름 | 설명                                    |
| --------- | --------------------------------------- |
| src       | 음악 파일의 경로 지정                   |
| preload   | 음악을 재생하기 전에 모두 불러올지 지정 |
| autoplay  | 음악을 자동 재생할지 지정               |
| loop      | 음악을 반복할지 지정                    |
| controls  | 음악 재생 도구를 출력할지 지정          |

```html

<!--audio.html-->

<!DOCTYPE html>
<html>
	<head>BASIC HTML Page</head>
	<body>
		<br />
		<audio src="audio.wav" controls="controls" ></audio>
	</body>
</html>

```

### audio 태그의 속성 표기 방법

[[HTML]] 문서에 나와있듯이 HTML 페이지의 표기법에는 XHTML 표기법과 HTML5 표기법이 있다.

방금의 예제와 같이 표기하는 방식이 XHTML5 표기법이다.

HTML5 표기법은 아래와 같이 작성한다.

```html

<audio src="audio.wav" controls></audio>

```

## source 태그

웹 브라우저에 따라 위의 audio.html 예제가 실행되지 않을수도 있다.
웹 브라우저마다 지원하는 음원 형식 포맷이 다르기 때문이다.

이러한 문제를 해결하기 위해 source 태그가 탄생하였다.

source 태그는 img 또는 video 안에 입력하는 태그이며 아래의 코드와 같이 사용한다.

```html

<body>
	<audio controls="controls">
		<source src="audio.mp3" type="audio/mp3" />
		<source src="audio.ogg" type="audio/ogg" />
	</audio>
</body>

```

mp3 파일과 ogg 파일을 사용하면 모든 브라우저에서 음악을 재생할 수 있다.

## 비디오 태그

동영상을 재생하기 위해 video 태그를 사용하여야 한다.

video 태그에서 주로 사용되는 특성은 아래와 같다.

| 속성 이름 | 설명                                        |
| --------- | ------------------------------------------- |
| src       | 비디오 파일의 경로 지정                     |
| poster    | 비디오 준비 중일 때의 이미지 파일 경로 지정 |
| preload   | 비디오를 재생하기 전에 모두 불러올지 지정   |
| autoplay  | 비디오를 자동 재생할지 지정                 |
| loop      | 비디오를 반복할지 지정                      |
| controls  | 비디오 재생 도구를 출력할지 지정            |
| width     | 비디오의 너비를 지정                        |
| height    | 비디오의 높이를 지정                                            |

mp4 형식과 webm 형식을 사용하면 모든 브라우저에서 비디오를 재생할 수 있으므로 video, source 태그를 사용하여 아래와 같이 작성한다.

```html

<!--video.html-->

<!DOCTYPE html>
<html>
	<head>BASIC HTML Page</head>
	<body>
		<br />vi
		<video controls="controls">
			<source src="video.mp4" type="video/mp4" />
			<source src="video.mp4" type="video/webm" />
		</video>
	</body>
</html>

```

## track 태그

(생략)

## 입력 양식 태그

입력 양식은 사용자에게 입력받는 공간을 의미한다. 입력 양식 태그는 입력 양식을 만들 때 사용하는 태그이다.

사실 입력 양식을 제대로 다루려면 서버와 관련된 기술을 알아야 한다. 하지만 본문에서 참고한 자료는 입문용이므로 서버와 관련된 기술을 다룰 수 없다. 따라서 입력 양식과 관련된 기본적인 내용만 살펴본다.

입력 양식은 form 태그를 사용해 생성한다.
입력 양식 안에는 input 태그를 입력한다.

```html

<!--input.html-->
<!DOCTYPE html>

<html>
<head>BASIC HTML Page</head>
<body>
	<br />
	<form>
		<input type="text" name="search" />
		<input type="submit" />
	</form>
</body>
</html>

```

form 태그의 속성 중 일반적으로 쓰이는 속성은 아래와 같다.

| 속성 이름 | 설명                               |
| --------- | ---------------------------------- |
| action    | 입력 데이터의 전달 위치를 지정한다 |
| method    | 입력 데이터의 전달 방식을 선택한다 |

더 깊게 들어가면 클라이언트와 관련된 내용이 아니라 서버와 관련된 내용이므로 차후 보충하도록 하겠습니다.

### 기본 input 태그

input 태그는 방금 말했듯이 사용자로부터 정보를 입력받는 기능을 수행하는 태그이다. 방금 살펴보았던 것처럼 사용자에게 글자를 입력받는 것은 물론 비밀번호와 파일을 입력받을 수도 있다.

input 태그의 type 속성값을 지정하므로서 이러한 세부사항들을 설정할 수 있다.

| 속성값   | 설명                           |
| -------- | ------------------------------ |
| button   | 버튼을 생성한다.               |
| checkbox | 체크박스를 생성한다.           |
| file     | 파일 입력 양식을 생성한다.     |
| hidden   | 보이지 않게 한다.              |
| image    | 이미지 형태를 생성한다.        |
| password | 비밀번호 입력 양식을 생성한다. |
| radio    | 라디오 버튼을 생성한다.        |
| reset    | 초기화 버튼을 생성한다.        |
| submit   | 제출 버튼을 생성한다.          |
| text     | 글자 입력 양식을 생성한다.     |

다음과 같은 예제를 실행하여 결과를 확인해보자.

```html

<!--input2.html-->

<!DOCTYPE html>
<html>
	<head>Basic HTML Page</head>
	<body>
		<form>
			<input type="text" /><br />
			<input type="buttom" /><br />
			<input type="checkbox" /><br />
			<input type="file" /><br />
			<input type="hidden" /><br />
			<input type="image" /><br />
			<input type="password" /><br />
			<input type="radio" /><br />
			<input type="reset" /><br />
			<input type="submit" /><br />
		</form>
	</body>
</html>

```

### HTML5 입력 양식 태그

방금 전에 살펴본 input 태그는 HTML4에서 지원하던 input 태그이다. HTML5는 아래의 표의 type 속성값을 추가로 지원한다.

| 속성값         | 설명                            |
| -------------- | ------------------------------- |
| color          | 색상 선택 양식을 생성한다.      |
| date           | 일 선택 양식을 생성한다.        |
| datetime       | 날짜 선택 양식을 생성한다.      |
| datetime-local | 지역 날짜 선택 양식을 생성한다. |
| email          | 이메일 입력 양식을 생성한다.    |
| month          | 월 선택 양식을 생성한다.        |
| number         | 숫자 생성 양식을 생성한다.      |
| range          | 범위 선택 양식을 생성한다.      |
| search         | 검색어 입력 양식을 생성한다.    |
| tel            | 전화 번호 입력 양식을 생성한다. |
| time           | 시간 선택 양식을 생성한다.      |
| url            | URL 주소 입력 양식을 생성한다.  |
| week           | 주 선택 양식을 생성한다.        |

```html

<!--input3.html-->

<!DOCTYPE html>

<html>
<head>BASIC HTML Page</head>
	<body>
		<form>
			<input type="color" /><br />
			<input type="date" /><br />
			<input type="datetime" /><br />
			<input type="datetime-local" /><br />
			<input type="email" /><br />
			<input type="month" /><br />
			<input type="number" /><br />
			<input type="range" /><br />
			<input type="search" /><br />
			<input type="tel" /><br />
			<input type="time" /><br />
			<input type="url" /><br />
			<input type="week" /><br />
		</form>
	</body>
</html>

```

## textarea 태그

input 양식이 아닌 입력 양식이 2개 있다. textarea 태그와 select 태그이다.

textarea 태그는 글상자를 통해 입력을 받게 해주는 태그이다.
textarea 태그는 아래와 같이 사용한다.

```html

<!--textarea.html-->

<!DOCTYPE html>

<html>
	<head><title>BASCI HTML PAGE</title></head>
	<body>
		<form>
			<textarea></textarea>
		</form>
	</body>
</html>

```

아래의 속성들을 통해 글상자의 크기를 지정할 수 있다.

| 속성 이름 | 설명                    |
| --------- | ----------------------- |
| cols      | 태그의 너비를 지정한다  |
| rows      | 태그의 높이를 지정한다 |

마지막으로 textarea 태그 안에 미리 글자를 입력하고 싶으면 아래처럼 태그 사이에 글자를 입력한다.

```html

<!--만약 2줄을 열을 맞춰서 깔끔하게 입력하고 싶다면 아래와 같이 입력해야 한다-->

<body>
	<textarea>글상자
글상자</textarea>
</body>

```

## select 태그

select 태그는 여러 개의 목록에서 몇 가지를 선택할 수 있는 입력 양식 요소이다. select 태그를 사용할 때는 아래의 표의 태그는 함께 사용한다.

| 태그 이름 | 설명                  |
| --------- | --------------------- |
| select    | 선택 양식을 생성한다. |
| optgroup  | 옵션을 그룹화한다.    |
| option    | 옵션을 생성한다.      |

select 태그의 multiple 옵션을 체크하므로서 여러개의 선택 항목을 동시에 선택하도록 할 수 있다.

```html

<!--select.html-->

<!DOCTYPE html>
<html>
<head><title>BASIC HTML PAGE</title></head>
	<body>
		<select>
			<option>김밥</option>
			<option>떡볶이</option>
			<option>순대</option>
			<option>오뎅</option>
		</select>
		<br />
		<select multiple="multiple">
			<optgroup label="HTML5">
				<option>Multimedia Tag</option>
				<option>Connectivity</option>
				<option>Device Access</option>
			</optgroup>
			<optgroup label="CSS3">
				<option>Animation</option>
				<option>3D Transform</option>
			</optgroup>
		</select>
	</body>
</html>

```

하지만 select 태그는 결과물이 예쁘지 않고, 자바스크립트 등의 대체 수단이 존재하기 때문에 현재에는 거의 사용되지 않는다.

## fieldset, legend 태그

이 두 태그는 입력 양식을 **입력 양식 폼**에 넣어 정돈하기 위하여 사용된다.

```html

<!--input_form.html-->

<!DOCTYPE html>
<html>
	<head><title>BASIC HTML PAGE</title></head>
	<body>
		<form>
			<fieldset>
				<legend>입력 양식</legend>
				<table>
					<tr>
						<td><label for="name">이름</label></td>
						<td><input id="name" type="text" /></td>
					</tr>
					<tr>
						<td><label for="mail">이메일</label></td>
						<td><input id="mail" type="email" /></td>
					</tr>
				</table>
				<input type="submit" />
			</fieldset>
		</form>
	</body>
</html>

```

## div 태그와 span 태그

공간을 분할하는 이유는 공간을 분할해야 [[CSS]]를 사용해 우리가 원하는 레이아웃을 구성할 수 있기 때문이다.

대표적인 공간 분할 태그는 div 태그와 span 태그이다.

| 태그 이름 | 설명                            |
| --------- | ------------------------------- |
| div       | block 형식으로 공간을 분할한다  |
| span      | inline 형식으로 공간을 분할한다 |

```html

<!--div.html-->

<!DOCTYPE html>
<html>
	<head><title>basic html page</title></head>
	<body>
		<div>Lorem ipsum</div>
		<div>Lorem ipsum</div>
		<div>Lorem ipsum</div>
		<div>Lorem ipsum</div>
		<div>Lorem ipsum</div>
	</body>
</html>

```

block 형식이란 차곡차곡 공간을 분할하는 형식을 말한다.
따라서 글자가 웹 페이지의 너비만큼 차지하면서 쌓아 올려진다.

반면 inline 형식은 한 줄 안에 차례차례 위치하는 형식을 말한다.

```html

<!--span.html-->

<!DOCTYPE html>
<html>
	<head><title>basic html page</title></head>
	<body>
		<span>Lorem ipsum</span>
		<span>Lorem ipsum</span>
		<span>Lorem ipsum</span>
		<span>Lorem ipsum</span>
		<span>Lorem ipsum</span>
	</body>
</html>

```

### block 형식과 inline 형식

div나 span 태그가 아니더라도 block 형식과 inline 형식 둘 중 하나에 속해 웹페이지의 공간을 차지한다.

| block 형식 태그 | inline 형식 태그 |
| --------------- | ---------------- |
| div             | span             |
| h1 ~ h6         | a                |
| p               | input            |
| 목록 태그       | 글자 형식 태그   |
| table          |                  |
| form            |                  |

# 시멘틱 구조 태그

사람은 눈으로 웹페이지의 레이아웃을 구분하므로 빠르게 구분할 수 있지만 컴퓨터는 그럴 수 없다.

따라서 기계적인 검색 엔진은 어떠한 태그가 어떠한 기능을 하는지 분별할 수 없고 웹 페이지에서 데이터를 효율적으로 추출할 수 없다. 이를 해결하고자 특정한 태그에 의미를 부여해 웹 페이지를 만드는 시도가 시작되었다. 이를 **시멘틱 웹**이라고 한다.

그리고 시멘틱 웹을 구현하려고 만들어지 태그가 바로 **HTML5 시멘틱 구조 태크**이다.

| 태그 이름 | 설명                                |
| --------- | ----------------------------------- |
| header    | 헤더를 의미                         |
| nav       | 내비게이션을 의미                   |
| aside     | 사이드에 위치하는 공간을 의미       |
| section   | 여러 중심 내용을 감싸는 공간을 의미 |
| article   | 글자가 많이 들어가는 부분을 의미    |
| footer    | 푸터를 의미                         |

이 이외에도 많은 시멘틱 태그가 있지만 너무 많으므로 일단 생략한다.

시멘틱 태그는 모두 div 태그와 같은 기능을 수행하는 태그이다. 하지만 이전에 언급했던 것처럼 태그는 검색 엔진이나 그 이외의 기계적인 동작들이 웹 페이지를 쉽게 이해할 수 있게 하는 데 의미가 있다.

예를 들어 아래의 코드는 HTML5 이전의 레이아웃 구성 방식이다.

```html

<!--non_sementic.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>non semantic</title>
	</head>
	<body>
		<div>
			<h1>HTML5 Header</h1>
		</div>
		<div>
			<ul>
				<li><a href="#">Menu - 1</a></li>
				<li><a href="#">Menu - 2</a></li>
				<li><a href="#">Menu - 2</a></li>
			</ul>
		</div>
		<div>
			<div>
				<h1>Lorem ipsum dolor sit amet</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</div>
			<div>
				<h1>Lorem ipsum dolor sit amet</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</div>
		</div>
		<div>
			<span>서울특별시 강서구 내발산동</span>
		</div>
	</body>
</html>

```

```html

<!--sementic.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>semantic</title>
	</head>
	<body>
		<header>
			<h1>HTML5 Header</h1>
		</header>
		<nav>
			<ul>
				<li><a href="#">Menu - 1</a></li>
				<li><a href="#">Menu - 2</a></li>
				<li><a href="#">Menu - 2</a></li>
			</ul>
		</nav>
		<section>
			<article>
				<h1>Lorem ipsum dolor sit amet</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</article>
			<article>
				<h1>Lorem ipsum dolor sit amet</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</article>
		</section>
		<footer>
			<address>서울특별시 강서구 내발산동</address>
		</footer>
	</body>
</html>

```

사람의 눈으로 보아도 각 단락의 역할을 명확하게 구분할 수 있다.

---

참고자료

#참고도서/모던_웹_디자인을_위한_HTML5_CSS3_입문 

---
