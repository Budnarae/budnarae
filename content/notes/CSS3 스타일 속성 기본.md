---
title: '*visual studio에서 Ctrl + Spacebar로 스타일 속성 선택지를 확인할 수 있으므로 미련하게 꾸역꾸역 외우지 말자*'
tags:
  - 'language/css'
  - 'web'
---

#  CSS3 단위

스타일 속성은 아래의 코드처럼 입력한다. 이때 오른쪽에 입력하는 값은 특정한 단위를 갖는다. 이 절에서는 스타일시트에서 사용하는 단위를 알아본다.

```html

<style>
	h1 {
		margin: 10px;
		font-size: 200%;
		line-height: 2em;
	}
</style>

```

## 키워드

키워드는 CSS3에서 가장 쉽게 사용할 수 있는 단위이다. 각각의 스타일 속성에 따라 별도의 키워드가 존재한다.

## 크기 단위

크기 단위는 CSS3에서 가장 많이 사용하는 단위이다. CSS3에서 사용하는 크기 단위는 **%, em, cm, mm, inch, px**이다. 이중에서 자주 사용하는 크기 단위는 아래와 같다.

| 단위 | 설명        |
| ---- | ----------- |
| %    | 백분율 단위 |
| em   | 배수 단위   |
| px   | 픽셀            |

첫번째로 알아볼 단위는 퍼센트 단위이다. 퍼센트 단위는 기본 설정된 크기에서 상대적으로 크기를 지정한다. 100%가 초기에 설정된 크기이다.

```html

<!--percent.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			p:nth-child(1) { font-size: 0% }
			p:nth-child(2) { font-size: 100% }
			p:nth-child(3) { font-size: 150% }
			p:nth-child(4) { font-size: 200% }
		</style>
	</head>
	<body>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>

```

두번째로 알아볼 크기 단위는 em 단위이다. em 단위는 배수를 나타내는 단위이다. 1배=1em=100%이며 1.5배=1.5em=150%이다.

```html

<!--percent.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			p:nth-child(1) { font-size: 0.0em; }
			p:nth-child(2) { font-size: 1.0em; }
			p:nth-child(3) { font-size: 1.5em; }
			p:nth-child(4) { font-size: 2.0em; }
		</style>
	</head>
	<body>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>
```

% 단위와 em 단위는 모두 상대적으로 크기를 지정한다. 절대적으로 크기를 지정할 때는 px 단위를 사용한다. 참고로 p 태그의 기본 font-size 속성이 16픽셀이다.

```html

<!--percent.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			p:nth-child(1) { font-size: 0px; }
			p:nth-child(2) { font-size: 16px; }
			p:nth-child(3) { font-size: 24px; }
			p:nth-child(4) { font-size: 32px; }
		</style>
	</head>
	<body>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>

```

### 크기 단위의 복합 사용

폰트 크기를 지정할 때는 크기 단위를 섞어서 사용하는 경우가 많다. 이번에는 크기 단위를 섞어서 사용하는 방법을 살펴보자.

아래의 코드는 절대 크기 단위와 상대 크기 단위를 섞어서 폰트 크기를 지정한다.

```html

<!--combined.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 property Basic</title>
		<style>
			* { font-size:12px; }
			h1 { font-size:3.0em; }
			h2 { font-size:1.5em; }
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor sit amet</h1>
		<h2>consectetur adipiscing elit. Sed nec purus elit, nec cursus dolor.</h2>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec purus elit.</p>
	</body>
</html>

```

전체 폰트 크기에 절대 크기를 지정하고 각각의 태그에 상대 크기를 지정하는 방법은 많이 사용되므로 기억하는 것이 좋다.

### 제로

크기 단위 0을 입력하는 경우 단위를 입력하지 않아도 된다. 개발자의 취향에 따라서 0을 입력하는 경우에도 단위를 표기하는 경우가 있고 표기하지 않는 경우도 있다.

## 색상 단위

색상을 입력하는 가장 간단한 방법은 아래의 코드처럼 키워드를 입력하는 것이다.

```html

<style>
	h1 { background-color: red; }
	h2 { background-color: orange; }
	h3 { background-color: blue; }
	h4 { background-color: green; }
	h5 { background-color: brown; }
	h6 { background-color: purple; }
<\style>

```

하지만 단어로 표현할 수 있는 색상은 제한되어 있으므로 더욱 다양한 색상 표현을 위해 아래의 표와 같은 색상 단위를 제공한다.

| 단위 형태                               | 설명           |
| --------------------------------------- | -------------- |
| \#000000                                | HEX 코드 단위  |
| rbg(red, green, blue)                   | RGB 색상 단위  |
| rbga(red, green, blue, alpha)           | RGBA 색상 단위 |
| hsl(hue, saturation, lightness)         | HSL 색상 단위  |
| hsla(hue, saturation, lightness, alpha) | HSLA 색상 단위 |

> ## 알파 값
> RGBA와 HSLA의 A는 투명도를 의미하는 알파 값이다. 알파 값은 0.0부터 1.0 사이의 숫자를 입력한다. 0.0을 입력할 경우에는 완전히 투명한 상태를 나타내고 1.0을 입력할 경우에는 불투명한 상태를 나타낸다.

rgb 단위는 red, green, blue의 조합을 사용하여 색상을 표현하는 단위이다.
RGB 색상은 다음과 같이 사용한다. 각각의 숫자는 0부터 255까지 입력할 수 있다.

```html

<style>
	h1 { background-color: rgb(255,255,255); }
<\style>

```

HEX 코드 단위는 RGB 색상 단위를 짧게 입력하는 방법이다. HEX 코드는 16진수로 RGB 색상 조합을 순서대로 입력한다.

```html

<style>
	h1 { background-color: #0094FF;}
<\style>

```

HSL 색상은 색상 Hue, 채도 Saturation, 명도 Lightness를 사용한다.
아래와 같이 입력한다.

```html

<style>
	h1 { background-color: hsl(33, 100%, 50%);}
<\style>

```

## URL 단위

CSS3에서 이미지 파일이나 폰트 파일을 불러올 때는 URL 단위를 사용한다. 간단히 아래의 예제를 통해서 URL 단위의 사용법에 대해서 알아보자.

```html

<!--url.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 property Basic</title>
		<style>
			body {
				background-image: url('Desert.jpg');
			}
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor amet.</h1>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>

```

url() 함수 내부에 경로를 입력하면 된다. URL 경로를 입력할 때는 아래처럼 복잡한 경로를 사용할 수 있다.

```html

/* 현재 폴더의 Desert.jpg */
background-image: url('Desert.jpg');

/* 현재 폴더 내부의 Other 폴더의 Desert.jpg */
background-image: url('Other/Desert.jpg');

/* 루트 폴더의 Desert.jpg */
/* 루트 폴더의 개념은 서버를 알아야 한다 */
background-image: url('/Desert.jpg');

```

## 가시 속성

가시 속성은 태그가 화면에 보이는 방식을 지정하는 속성이다.

### display 속성

display 속성 중 주로 사용되는 속성으로는 다음이 있다.

| 키워드 이름  | 설명                                   |
| ------------ | -------------------------------------- |
| none         | 태그를 화면에서 보이지 않게 만든다.    |
| block        | 태그를 block 형식으로 지정한다.        |
| inline       | 태그를 inline 형식으로 지정한다.       |
| inline-block | 태그를 inline-block 형식으로 지정한다. |

다음은 위의 표 중 none 키워드를 사용한 예제이다. 다른 키워드를 사용할 땐 display의 키워드를 변경해주면 된다.

```html

<!--none.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			#box {
				display: none;
			}
		</style>
	</head>
	<body>
		<span>Dummy</span>
		<div id="box">
			<span>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</span>
		</div>
		<span>Dummy</span>
	</body>
</html>

```

코드를 실행했을 때, 단순히 보기에는 inline 형식과 inline-block 형식 모두 동일하게 출력되는 듯 하다.

하지만 width 속성과 height 속성, maring 속성을 사용할 때 2가지 형식의 차이를 확인할 수 있다.

```html

<!--inline.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			#box {
				display: inline;

				background-color: red;
				width: 300px; height: 50px;
				margin: 10px;
			}
		</style>
	</head>
	<body>
		<span>Dummy</span>
		<div id="box">
			<span>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</span>
		</div>
		<span>Dummy</span>
	</body>
</html>

```

```html

<!--inline-block.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			#box {
				display: inline-block;

				background-color: red;
				width: 300px; height: 50px;
				margin: 10px;
			}
		</style>
	</head>
	<body>
		<span>Dummy</span>
		<div id="box">
			<span>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</span>
		</div>
		<span>Dummy</span>
	</body>
</html>

```

inline 키워드를 적용한 코드는 width 속성과 height 속성이 적용되지 않는다. 또한 margin 속성이 div 태그의 좌우로만 지정된다.

반면에 inline-block 키워드를 적용하면 width 속성과 height 속성을 적용할 수 있다. 또한 margin 속성이 상하좌우로 적용된다. 이러한 특징은 block 키워드와 동일하다.

### visibility 속성

visiblity 속성은 대상을 보이거나 보이지 않게 지정하는 스타일 속성이다. visibility 속성에는 다음과 같은 키워드들을 사용한다.

| 키워드 이름 | 설명                            |
| ----------- | ------------------------------- |
| visible     | 태그를 보이게 만든다            |
| hidden      | 태그를 보이지 않게 만든다       |
| collapse    | table 태그를 보이지 않게 만든다 |

위 절에서 살펴본 display 속성의 none 키워드도 대상을 화면에서 보이지 않게 만든다. 따라서 display 속성의 none 키워드와 visibility 속성의 hidden 키워드의 차이를 아는 것이 중요하다.

none 키워드를 사용하면 해당 블록이 완전히 사라지지만, hidden 키워드를 사용하면 해당 블록의 공간 자체는 남아있고 내용물만 보이지 않게 된다는 차이점이 있다.

> ## collapse 속성
> visibility의 다른 키워드인 hidden도 table에 적용하는 것이 가능하다. 하지만 hidden은 내용물을 보이지 않게 할 뿐 표의 공간 자체는 남아있는 반면, collapse 속성은 none과 같이 표 자체를 없애버린다는 차이점이 있다.

```html

<!--collapse.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Selector Basic Page</title>
		<style>
			table {
				visibility: collapse;
			}
		</style>
	</head>
	<body>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<table>
			<tr><td>TEST</td><td>Test</td></tr>
			<tr><td>TEST</td><td>Test</td></tr>
			<tr><td>TEST</td><td>Test</td></tr>
		</table>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>

```

### opacity 속성

opacity 속성은 태그의 투명도를 조절하는 스타일 속성이다. opacity 속성에는 0.0부터 1.0 사이의 숫자를 입력할 수 있으며 0.0은 완전히 투명한 상태를 나타내고 1.0은 완전히 불투명한 상태를 나타낸다.

예를 들어 아래처럼 0.2를 적용하면 약간 투명한 상태로 보인다.

```html

<!--opacity.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Basic Page</title>
		<style>
			#box {
				background-color: black;
				color: white;

				opacity: 0.2;
			}
		</style>
	</head>
	<body>
		<div id="box">lorem ipsum dolor sit amet,
			consectetur adipiscing elit.
		</div>
	</body>
</html>

```

## 박스 속성

박스 속성은 웹 페이지의 레이아웃을 구성할 때 가장 중요한 스타일 속성이다. CSS는 다음과 같은 속성을 모두 합쳐 박스 속성이라고 이야기한다.

- margin
- border
- padding
- height
- width

테두리 border 속성은 내용이 많으므로 다음 절에서 다루도록 한다. 이 절에서는 width 속성, height 속성, margin 속성, padding 속성을 알아보도록 한다.

### width 속성과 height 속성

width 속성과 height 속성은 글자를 감싸는 영역의 크기를 지정하는 스타일 속성이다. 

```html

<!--width_height.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS Property Basic</title>
		<style>
			div {
				width: 100px; height: 100px;
				background-color: red;
			}
		</style>
	</head>
	<body>
		<div></div>
	</body>
</html>

```

코드를 실행하면 div 태그의 너비와 높이가 100픽셀로 지정된다.

### margin 속성과 padding 속성

maring 속성은 마진의 너비를 지정하는 속성이고 padding 속성은 패딩의 너비를 지정하는 속성이다.

margin과 padding은 영역을 둘러싸는 추가적인 여백이라고 생각될 수 있다.

아래의 코드는 margin 속성에 10픽셀을 적용하고 padding 속성에 30픽셀을 적용한다.

```html

<!--margin_padding.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS Property Basic</title>
		<style>
			div {
				width: 100px; height: 100px;
				background-color: red;

				border: 20px solid black;
				margin: 10px; padding: 30px;
			}
		</style>
	</head>
	<body>
		<div></div>
	</body>
</html>

```

margin 속성을 사용할 떄 각각의 너비를 별도로 지정할 수 있다. 아래의 예제와 같이 순서대로 크기 단위를 띄워쓰기로 구분해 적용하면 된다.

```html

margin: 10px 20px 30px 40px;

```

그리고 다음과 같이 margin과 padding 속성에 2개의 값을 적용하는 경우도 있다.
이 경우 2개의 값은 각각 margin과 padding의 세로, 가로 값을 의미한다.

```html

<style>
	div {
		width: 100px; height: 100px;
		background-color: red;

		/* margin: 위아래 왼쪽오른쪽 */
		/* padding: 위아래 왼쪽오른쪽 */
		margin: 0 30px; padding: 0 30px;
	}
</style>

```

### box-sizing 속성

앞 절에서 width 속성과 height 속성은 글자를 감싸는 영역의 크기를 지정하는 스타일 속성이라고 이야기하였다. box-sizing 속성은 이러한 공식을 변경할 수 있는 CSS3 속성이다.

box-sizing 속성은 width 속성과 height 속성이 차지하는 범위를 지정한다. box-sizing 속성은 다음의 키워드들을 사용한다.

- border-box
- content-box
- inherit
- initial

```html

<!--box-sizing.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			div{
				margin: 10px; padding: 10px;
				width: 100px; height: 100px;
				border: 10px solid black;
			}

			div:first-child {
				background: red;
				box-sizing: content-box;
			}
			
			div:last-child {
				background: orange;
				box-sizing: border-box;
			}
		</style>
	</head>
	<body>
		<div></div>
		<div></div>
	</body>
</html>

```

content-box 키워드는 기본으로 적용되는 키워드이다. content-box 키워드를 적용하면 width 속성과 height 속성이 글자가 들어가는 영역의 크기를 지정하게 만든다. 따라서 content-box의 너비와 높이는 다음과 같은 공식으로 표기할 수 있다.

*박스 너비 = width 속성 + 2 x (margin 속성 + border 속성 + padding 속성)*
*박스 높이 = width 속성 + 2 x (margin 속성 + border 속성 + padding 속성)*

border-box 키워드는 width속성과 height 속성이 테두리를 포함한 영역의 크기를 지정하게 만든다. 따라서 생성되는 영역의 전체 너비와 높이는 다음과 같은 공식으로 표기할 수 있다.

*박스 너비 = width 속성 + 2 x margin 속성*
*박스 높이 = height 속성 + 2 x margin 속성*

## 테두리 속성

테두리 속성은 원래 박스 속성이다. 하지만 분량이 굉장히 많은 관계로 별도로 분류하였다.

### border-width 속성과 border-style 속성

이번 주제에서는 border-width 속성과 border-style 속성을 살펴본다.

우선 border-width 속성은 테두리의 너비를 지정하는 스타일 속성이다.
border-style 속성은 테두리의 형태를 지정하는 속성이다.

아래의 예제를 보자.

```html

<!--border_style.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			.box {
				border-width: thick;
				border-style: dashed;
				border-color: black;
			}
		</style>
	</head>
	<body>
		<div class="box">
			<h1>Lorem ipsum dolor amet</h1>
		</div>
	</body>
</html>

```

위 코드를 실행하면 두꺼운 dashed 형태의 검정색 테두리가 형성된다.

위 코드를 한 줄로 입력하면 아래와 같이 입력할 수 있다.

```html

<style>
	.box {
		border: thick dashed black;
	}
</style>

```

border 속성은 margin 속성과 padding 속성처럼 left, top, right, bottom 부분의 값을 적용할 수 있다.

```html

<style>
	.box {
		border-left: thick dashed black;
	}
</style>

```

### border-raduis 속성

border-radius 속성은  css3에서 추가된 속성이다. border-radius 속성을 사용하면 테두리가 둥근 사각형 또는 원을 만들 수 있다.

```html

<style>
	.box {
		border: thick dashed black;
		border-radius: 20px;
	}
</style>

```

다음과 같은 기법들을 적용시킬 수도 있다.

```html

<style>
	.box {
		/*border-width: thick;
		border-style: dashed;
		border-color: black;*/

		/* 한 줄로 입력하려면
		border: thick dashed black;*/

		/* 둥근 모서리 만들기
		border: thick dashed black;
		border-radius: 20px; */

		/* 모서리 각각의 각을 다르게 하기 */
		border: thick dashed black;
		border-radius: 50px 40px 20px 10px;
	}
</style>

```

## 배경 속성

배경 속성은 특정 태그의 배경 이미지 또는 색상을 지정하는 스타일 속성이다.

### background-image 속성

background-image 속성은 배경에 넣을 그림을 지정하는 스타일 속성이다.
background-image 속성에는 URL 단위 또는 그레이디언트를 입력한다.

이 절에서는 URL 단위에 대해서만 다루고 그레이디언트는 나중에 다루도록 한다.

```html

<!--background_image.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 property Basic</title>
		<style>
			body {
				background-image: url('BackgroundFront.png');
			}
		</style>
	</head>
	<body>
		
	</body>
</html>

```

위의 예제를 실행시키면 body 태그가 차지하는 영역에 (즉 화면 전체에) 배경 이미지를 적용할 수 있다.

### background-size 속성

그림 크기를 조절할 때는 background-size 속성을 사용한다. background-size 스타일 속성은 CSS3에서 추가된 속성이다.

background-size 속성에는 크기 단위 또는 키워드를 사용한다.

background-size 속성은 1개 또는 2개의 크기 단위를 적용하며 각각 너비와 높이를 의미한다.

```html

<!--background_size.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 property Basic</title>
		<style>
			body {
				background-image: url('BackgroundFront.png');
				background-size: 100%;

				/* 두 번째 속성은 높이를 의미한다. 
				background-size: 100% 250px */
			}
		</style>
	</head>
	<body>
		
	</body>
</html>

```

### background-size 속성의 키워드

background-size 속성에는 contain 키워드와 cover 키워드를 적용할 수 있다.

background-size 속성에 contain 키워드를 적용하면 너비를 100%로 적용한 것과 같은 효과를 낸다.
cover 키워드를 적용하면 높이를 100%로 적용한 것과 같은 효과를 낸다.

### background-repeat 속성

background의 높이를 100%보다 작게 주면 그림이 패턴을 이루어 여러 개 출력되는 것을 볼 수 있다. 이는 background-repeat 속성의 기본 키워드가 repeat이므로 나타나느니 형상이다. background-repeat 속성에는 다음의 종류가 있다.

| 키워드 종류 | 설명                            |
| ----------- | ------------------------------- |
| repeat      | 이미지가 패턴을 이룬다          |
| repeat-x    | x축 방향으로 이미지가 반복된다. |
| repeat-y    | y축 방향으로 이미지가 반복된다. |
| no-repeat   | 패턴이 반복되지 않는다.         |

### background-attachment 속성

background-attachment 속성은 배경 이미지를 어떠한 방식으로 화면에 붙일 것인지를 지정하는 스타일 속성이다.

background-attachment 속성의 기본 키워드는 scroll 키워드이다. scorll 키워드는 화면 스크롤에 따라 배경 이미지가 함께 이동함을 의미한다.

fixed 키워드를 사용하면 화면 스크롤 유무에 관계없이 화면에 배경 이미지가 고정된다.

```html

<!--background_attachment.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			body {
				background-color: #E7E7E8;
				background-image: url('BackgroundFront.png'), url('BackgroundBack.png');
				background-size: 100%;
				background-repeat: no-repeat;
				background-attachment: fixed;
			}
		</style>
	</head>
	<body>
		<p>very long text</p>
	</body>
</html>

```

### background-position 속성

background-position 속성에는 다음과 같은 형태로 값을 적용한다.

- background-position: 키워드;
- background-position: X축 크기;
- background-position: X축 크기 Y축 크기;

키워드를 사용하는 경우의 예시를 보자. 다음과 같이 코드를 실행하면 배경 이미지가 아래에 붙는다.

```html

<style>
	body {
		background-color: #E7E7E8;
		background-image: url('BackgroundFront.png'), url('BackgroundBack.png');
		background-size: 100%;
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-position: bottom;
	}
</style>

```

2개의 값을 입력하면 각각 X축 위치와 Y축 위치를 적용한다. 다음의 코드는 X축 위치를 0픽셀로 적용하고 Y축 위치를 50%로 적용하는 코드이다.

```html

<style>
	body {
		background-color: #E7E7E8;
		background-image: url('BackgroundFront.png'), url('BackgroundBack.png');
		background-size: 100%;
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-position: 0px 50%;
	}
</style>

```

## background 속성

지금까지 배운 모든 배경 속성은 background 속성 한 번에 사용할 수 있다.
W3C 표준안은 background 속성에 다음 형태를 입력하라고 지정하고 있다.

```
<final-bg-layer> = <bg-image> || <position> [ / <bg-size> ]? || <repeat-style> || <attachment> || <box>{1,2} || <'background_color'>
```

실제로는 아래와 같은 형식으로 입력한다.

## 폰트 속성

폰트 속성은 글자와 관련된 스타일 속성을 의미한다.

### font-size 속성

```html

<!--font-size.html-->

<!DOCTYPE html>
<html>
<head>
	<title>CSS3 Font Property</title>
	<style>
		.a { font-size: 32px; }
		.b { font-size: 2em; }
		.c { font-size: large; }
		.d { font-size: small; }
	</style>
</head>
<body>
	<h1>Lorem imsum</h1>
	<p class="a">lorem ipsum</p>
	<p class="b">lorem ipsum</p>
	<p class="c">lorem ipsum</p>
	<p class="d">lorem ipsum</p>
</body>
</html>

```

## font-family 속성

font_family 속성에는 사용자 컴퓨터에 설치된 폰트를 사용한다.

일반적으로 한 단어로 이루어진 폰트는 따옴표를 사용하지 않는다. 하지만 두 단어 이상으로 이루어지는 폰트는 따옴표를 반드시 사용해야 한다.

```html

<!--font-size.html-->

<!DOCTYPE html>
<html>
<head>
	<title>CSS3 Font Property</title>
	<style>
		.font_arial { font-family: Arial; }
		.font_roman { font-family: 'Times New Roman'; }
	</style>
</head>
<body>
	<h1 class="font_arial">Lorem imsum</h1>
	<p class="font_roman">Lorem ipsum</p>
</body>
</html>

```

폰트를 적용할 때는 주의할 점이 있다. 개발하고 있는 우리의 컴퓨터에는 설치되어 있지만 우리가 개발한 웹 페이지를 사용할 사용자에게는 폰트가 설치되어 있지 않을 수 있다.

일반적으로 이러한 문제를 예방하고자 font-family 속성을 여러 개 사용한다.

```html

<!--font-size.html-->

<!DOCTYPE html>
<html>
<head>
	<title>CSS3 Font Property</title>
	<style>
		.font_arial { font-family: '없는 폰트', Arial; }
		.font_roman { font-family: 'Times New Roman', Arial; }
	</style>
</head>
<body>
	<h1 class="font_arial">Lorem imsum</h1>
	<p class="font_roman">Lorem ipsum</p>
</body>
</html>

```

하지만 다국어 웹 페이지를 제공할 경우 사용자에게 무슨 폰트가 있는지 일일이 확인할 수 없다. 이러한 문제를 해결하고자 font-family 속성의 가장 마지막 폰트에는 Serif 폰트(명조체), Sans-serif 폰트(고딕체), Mono space 폰트(고정 폭 글꼴)을 적용한다.

이 폰트는 웹 브라우저에서 지정하는 generic-family 폰트라고 부른다.

### font-style 속성과 font-weight 속성

font-style 속성과 font-weight 속성은 폰트의 기울기 또는 두께를 조정하는 스타일 속성이다.

font-style 속성에는 키워드만을 사용한다.
font-weight 속성에는 단위 또는 키워드를 사용한다.

```html

<!--font_style_weight.html-->

<!DOCTYPE html>
<head>
	<head>
		<title>CSS3 Font Property</title>
		<style>
			.font_big { font-size: 2em; }
			.font_italic { font-style: italic; }
			.fint_bold { font-weight: bold; }
		</style>
	</head>
	<body>
		<p class="font_big font_italic font_bold">Lorem ipsum dolor amet</p>
	</body>
</head>

```

일반 폰트의 두꼐는 400이고 두꺼운 폰트의 두께는 700이다. 또한 두께를 지원하지 않는 폰트는 font-weight 속성을 사용해 두께를 조절할 수 없다.

### line-height 속성

line-height 속성은 글자의 높이를 지정한다. 현대의 HTML 페이지는 문서의 형태보다 애플리케이션의 형태로 사용하므로 글자의 높이를 지정하는 기능보다 글자를 수직 중앙 정렬할 때 사용한다.

CSS는 block 형식을 가지는 태그를 수직 정렬할 수 있는 스타일 속성이 없다. 따라서 대체 방안으로 line-height 속성을 사용한다.

```html

<!--align_button.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Font Property</title>
		<style>
			.font_big { font-size: 2em; }
			.font_italic { font-style: italic; }
			.font_bold { font-weight: bold; }
			.font_center { text-align: center; }

			.button {
				width: 150px;
				height: 70px;
				background-color: #FF6A00;
				border: 10px solid #FFFFFF;
				border-radius: 30px;
				box-shadow: 5px 5px 5px #A9A9A9
			}

			.button > a {
				display: block;
			}
		</style>
	</head>
	<body>
		<div class="button">
			<a href="#" class="font_big font_italic font_bold font_center">Click</a>
		</div>
	</body>
</html>

```

### text-align 속성

text-align은 글자의 정렬을 조작하는 속성이다.

```html

<!--text_align.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Font Property</title>
		<style>
			.font_big { font-size: 2em; }
			.font_italic { font-style: italic; }
			.font_bold { font-weight: bold; }
			.font_center { text-align: center; }
			.font_right { text-align: right; }
		</style>
	</head>
	<body>
		<p class="font_big font_italic font_bold font_center">Lorem ipsum dolor amet</p>
		<p class="font_bold font_right">2012.04.21</p>
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
	</body>
</html>

```

> #### text-align을 사용할 때 주의할 점
> text-align은 span 태그를 대상으로 동작하지 않는다. 왜냐하면 너비가 없으므로 중앙이라는 개념이 존재하지 않기 때문이다. 마찬가지로 inline 형식의 태그는 text-align을 적용할 수 없다.

### text-decoration 속성

text-decoration 속성은 링크의 밑줄을 지우는데 사용된다.

```html

<!--text_decoration.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Font Property</title>
		<style>
			a { text-decoration: none; }
		</style>
	</head>
	<body>
		<h1>
			<a href="#">Lorem ipsum dolor amet</a>
		</h1>
	</body>
</html>

```

text-decoration 속성으로는 밑줄만 제거되며 색상은 color 속성을 사용해 별도로 적용해야 한다.

## 위치 속성

프로그램을 개발할 때는 요소의 위치를 2가지 방법으로 설정한다.

- 절대 위치 좌표 : 요소의 X 좌표와 Y 좌표를 설정해 절대 위치를 지정한다.
- 상대 위치 좌표 : 요소를 입력한 순서를 통해 상대적으로 위치를 지정한다.

절대 위치 좌표는 드래그해서 만들 수 있으므로 상대 위치 좌표보다 개발하기 쉽다.
하지만 상대 위치 좌표가 훨씬 많이 사용된다. 예를 들어 안드로이드폰은 다양한 회사에서 만드므로 화면의 해상도가 다양하다. 따라서 안드로이드는 상대 위치 좌표를 사용해 개발한다. HTML 페이지도 사용자가 다양한 화면 크기로 실행할 수 있으므로 상대 위치 좌표를 사용한다.

일반적으로 절대 위치 좌표는 특정 크기의 영역을 지정한 태그 내부에서만 사용한다.

### position 속성

HTML 태그의 위치 설정 방법을 변경할 때는 position 속성을 사용한다.

상대 위치 좌표를 사용할 때는 position 속성에 static 키워드 또는 relative 키워드를 적용한다. static 키워드를 적용하면 태그가 "위에서 아래로"와 "왼쪽에서 오른쪽으로" 순서에 맞게 배치된다(direction 속성을 사용해 "오른쪽에서 왼쪽"으로 변경할 수 있다.)

relative 키워드를 적용하면 static 키워드로 초기 위치가 지정된 상태에서 상하좌우로 이동할 수 있다. 반면에 절대 위치 좌표를 사용할 때는 position 속성에 absolute 키워드 또는 fixed 키워드를 적용한다.

| 키워드   | 설명                                          |
| -------- | --------------------------------------------- |
| static   | 태그가 위에서 아래로 순서대로 배치된다        |
| relative | 초기 위치 상태에서 상하좌우로 위치를 이동한다 |
| absolute | 절대 위치 좌표를 설정한다                     |
| fixed    | 화면을 기준으로 절대 위치 좌표를 설정한다     |

```html

<!--absolute.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			.box {
				width: 100px; height: 100px;
				position: absolute;
			}
			.red { background-color: red; }
			.green { background-color: green; }
			.blue { background-color: blue; }
		</style>
	</head>
	<body>
		<div class="box red"></div>
		<div class="box green"></div>
		<div class="box blue"></div>
	</body>
</html>

```

위 코드는 어떤 브라우저로 실행시키냐에 따라서 결과가 상이할 수 있다.
모든 브라우저의 출력 방식을 통일하려면 아래와 같은 스타일 속성을 함께 사용해야 한다.

- top
- left
- right
- bottom

```html

<!--absolute.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			.box {
				width: 100px; height: 100px;
				position: absolute;
			}
			.red { background-color: red;
				left: 100px; top: 10px; }
			.green { background-color: green;
				left: 50px; top: 50px; }
			.blue { background-color: blue;
				left: 90px; top: 90px; }
		</style>
	</head>
	<body>
		<div class="box red"></div>
		<div class="box green"></div>
		<div class="box blue"></div>
	</body>
</html>

```

### z-index 속성

위 예제에서는 뒤에 입력한 파란색 사각형이 위로 올라온다. 이러한 순서를 변경하고 싶을 때는 z-index 속성을 사용한다. z-index 속성에는 숫자를 적용하며 숫자가 클수록 앞에 위치한다.

아래의 코드는 각각의 태그의 z-index 속성에 100, 10, 1을 적용하였다.

```html

<!--z-index.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			.box {
				width: 100px; height: 100px;
				position: absolute;
			}
			.box:nth-child(1) { 
				background-color: red;
				left: 10px; top: 10px;
			
				z-index: 100;
			}
			.box:nth-child(2) { 
				background-color: green;
				left: 50px; top: 50px; 
			
				z-index: 10;
			}
			.box:nth-child(3) { 
				background-color: blue;
				left: 90px; top: 90px;
			
				z-index: 1;
			}
		</style>
	</head>
	<body>
		<div class="box red"></div>
		<div class="box green"></div>
		<div class="box blue"></div>
	</body>
</html>

```

직전의 예제와 달리 빨간색 박스가 제일 앞쪽에 위치하는 것을 볼 수 있다.

### 위치 속성과 관련된 공식

position 속성에 absolute 키워드를 적용하면 부모 태그가 영역을 차지하지 않는다. 따라서 자손의 position 속성에 absolute 키워드를 적용할 경우는 부모 태그에 몇 가지 처리를 해야 한다.

이 문제를 해결할 때는 다음의 공식을 사용한다.

*자손의 position 속성에 absolute 키워드를 적용하면 부모는 height 속성을 사용한다*

이렇게 하면 부모 태그가 영역을 차지하게 만들 수 있다. 아래의 코드처럼 width 속성과 height 속성을 사용한다.

그리고 2번째 문제가 있다. 자손 요소들(박스들)이 부모의 위치를 기준으로 위치를 잡지 않는다는 것이다. 이 문제를 해결할 때는 다음의 방법을 사용한다.

*자손의 position 속성에 absolute 키워드를 적용하면 부모의 position 속성에 relative 키워드를 적용한다.*

이렇게 하면 자손 태그가 부모의 위치를 기준으로 절대 좌표를 설정한다. 이 공식에 따라서 div 태그에 position 속성을 사용한다.

```html

body > div {
	width: 400px; height: 100px;
	border: 3px solid black;

	position: relative;
}

```

### overflow 속성

overflow 속성은 내부의 요소가 부모의 범위를 벗어날 때 어떻게 처리할지 지정하는 속성이다.
overflow 속성에는 아래의 표의 키워드를 사용한다.

| 키워드 이름 | 설명                                      |
| ----------- | ----------------------------------------- |
| hidden      | 영역을 벗어나는 부분을 보이지 않게 만든다 |
| scroll      | 영역을 벗어나는 부분을 스크롤로 만든다    |

다음과 같이 적용할 수 있다.

```html

body > div {
	width: 400px; height: 100px;
	border: 3px solid black;

	position: relative;
	overflow: hidden;
}

```

```html

body > div {
	width: 400px; height: 100px;
	border: 3px solid black;

	position: relative;
	overflow: scroll;
}

```

overflow 속성에 scroll 키워드를 적용하면 무조건 모든 축에 스크롤이 생성된다. 만약 특정한 방향으로만 스크롤을 생성할 때는 overflow-x 속성과 overflow-y 속성을 사용한다.

```html

```html

body > div {
	width: 400px; height: 100px;
	border: 3px solid black;

	position: relative;
	overflow-y: scroll;
}

```

## float 속성

float 속성에는 많은 키워드가 있지만 주로 아래의 키워드만 사용된다,.

| 키워드 | 설명                   |
| ------ | ---------------------- |
| left   | 태그를 왼쪽에 붙인다   |
| right  | 태그를 오른쪽에 붙인다 |

### float 속성 개요

float 속성은 부유하는 대상을 만들 때 사용하는 스타일 속성이다.

```html

<!--float.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>Float Style Property</title>
		<style>
			
		</style>
	</head>
	<body>
		<img src="hanbit.jpg" />
		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
		<p>In hac habitasse platea dictumst. Donec lobortis angue a metus.</p>
	</body>
</html>

```

float의 개념을 이해하기 위해 먼저 위의 예제를 실행시켜보자. img 태그는 inline 형식의 태그이고 p태그는  block 형식의 태그이므로 그림과 글자가 분리되어 출력한다.

이제 float 속성을 적용시켜보자.

```html

<style>
	img {
		float: left;
	}
</style>

```

이미지가 글자 위에 부유하고 있는 모습을 볼 수 있을 것이다.

### float 속성을 사용한 수평 정렬

float 속성을 사용하면 태그를 수평으로 정렬할 수 있다. float 속성을 사용해 수평 정렬할 때는 주의할 점이 있으므로 아래처럼 div 태그에 각각의 태그를 구분할 수 있는 숫자를 입력한다.

```html

 <!--body 태그 구성-->

<body>
	<div class="box">1</div>
	<div class="box">2</div>
</body>

```

스타일시트에는 float 속성에 각각의 키워드를 적용한다.

```html

<style>
	.box {
		width: 100px; height: 100px;
		background-color: red;
		margin: 10px; padding: 10px;

		/* 태그를 왼쪽으로 붙인다. */
		float: left;
	}
</style>

<style>
	.box {
		width: 100px; height: 100px;
		background-color: red;
		margin: 10px; padding: 10px;

		/* 태그를 오른쪽으로 붙인다. */
		float: right;
	}
</style>

```

첫번째 style 블록은 아래와 같은 결과를 뱉는다.

```

| 1 2     |

```

두번째 style 블록은 아래와 같은 결과를 뱉는다.

```

|      1 2 |

```

### float 속성을 사용한 레이아웃 구성

float 속성을 사용해 레이아웃을 구성할 때는 아래의 공식을 숙지하고 있어야 한다.

*자손에 float 속성을 적용하면 부모의 overflow 속성에 hidden키워드를 적용한다*

우선 아래처럼 레이아웃의 기본적인 틀을 입력한다.

```html

<!--rayout.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>

		</style>
	</head>
	<body>
		<div id="header"><h1>Header</h1></div>
		<div id="navigation"><h1>Navigation</h1></div>
		<div id="wrap">
			<div id="aside">
				<h1>Aside</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</div>
			<div id="section">
				<h1>Section</h1>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			</div>
		</div>
		<div id="footer"><h1>Footer</h1></div>
	</body>
</html>

```

이제 스타일을 사용한다. 태그에 width 속성을 사용하고 margin-left, margin-right 속성에 auto 키워드를 적용하면 자동으로 중앙 정렬된다.

```html

<style>
	/* body 태그를 중앙 정렬한다 */
	body {
		width: 960px;
		margin: 0 auto;
	}
</style>

```

`#wrap` 태그 내부의 영역은 왼쪽과 오른쪽으로 구분되므로 아래처럼 입력한다.
`#aside`와 `#section` 태그에 width 속성과 float 속성을 사용한다.

```html

<style>
	/* body 태그를 중앙 정렬한다 */
	body {
		width: 960px;
		margin: 0 auto;
	}
	#aside {
		width: 200px;
		float: left;
	}
	#section {
		width: 760px;
		float: left;
	}
</style>

```

여기까지 실습을 진행했을 때 문제가 하나 있다. footer 태그는 페이지의 가장 하단에 있어야 하는 데 section 블록 밑에 붙어있을 것이다.

이는 근본적으로 float 태그가 요소를 부유시키기 때문에 발생하는 일로, 이를 해결하기 위해서는 이 절 맨 처음 서술했던 거처럼 float 속성을 사용한 태그의 부모에 overflow 속성을 사용하고 hidden 키워드를 적용한다.

```html
<style>
	/* body 태그를 중앙 정렬한다 */
	body {
		width: 960px;
		margin: 0 auto;
	}
	#aside {
		width: 200px;
		float: left;
	}
	#section {
		width: 760px;
		float: left;
	}
	#wrap { overflow: hidden; }
</style>

```

## 그림자 속성

그림자 속성은 태그에 그림자를 부여해주는 스타일 속성이다.

### text-shadwo 속성

text-shadow 속성은 글자에 그림자를 부여하는 스타일 속성이다. 아래의 그림의 형태로 값을 적용한다.

```bnf

text-shadow: <오른쪽> <아래> <흐림도> <색상>

```

```html

<!--text-shadow.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			h1 {
				text-shadow: 5px 5px 5px black;
			}
		</style>
	</head>
	<body>
		<h1>Lorem ipsum dolor amet</h1>
	</body>
</html>

```

### box-shadow 속성

box-shadow 속성은 박스에 그림자를 부여하는 속성이다. 아래의 형태로 값을 적용한다.

```bnf

box-shadow: <오른쪽> <아래> <흐림도> <색상>

```

```html

<!--text-shadow.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Property Basic</title>
		<style>
			div {
				border: 3px solid black;
				box-shadow: 10px 10px 30px black;
				text-shadow: 5px 5px 5px black;
			}
		</style>
	</head>
	<body>
		<div>
			<h1>Lorem ipsum dolor amet</h1>
		</div>
	</body>
</html>

```

### 중첩 그림자

그림자 속성은 쉼표를 사용해 여러 개의 그림자 키워드를 사용할 수 있다.

```html

<style>
	div {
		border: 3px solid black;
		box-shadow: 10px 10px 10px black, 10px 10px 20px orange, 10px 10px 30px red;
		text-shadow: 10px 10px 10px black, 10px 10px 20px orange, 10px 10px 30px red;
	}
</style>

```

## 자동화을 위해 아래의 링크를 애용합시다

[css3 생성기](https://css3generator.com/)

## 벤더 프리픽스

벤더 프리픽스 Vender Prefix는 웹 브라우저 공급 업체에서 제공하며, 실험적인 기능이 필요할 때 사용한다.
실험적인 기능은 웹 브라우저가 무턱대고 추가하기에는 무리가 있다.

하지만 다른 웹 브라우저를 이기려면 새로운 기능을 모두 제공해야 하므로 벤더 프리픽스를 사용해 지원한다. 아래는 벤더 프리픽스를 사용해 변환 효과를 적용하는 스타일 시트이다.

```html

<!--bender-prefix.html-->

<style>
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

```

위 예제에서 transition-duration 속성 앞에 붙어 있는 글자들이 벤더 프리픽스이다.

## 그레이디언트

그레이디언트는 2가지 이상의 색상을 혼합해서 채색하는 기능이다.

CSS3에서 그레이디언트를 구현하기 위한 형식은 복잡하므로 다음과 같은 [자동화 도구](https://www.colorzilla.com/gradient-editor/)의 힘을 빌리는 것이 좋다.

```html

 <!--gradient.html-->

<!DOCTYPE html>
<html>
	<head>
		<title>CSS3 Style Property Basic</title>
		<style>
			div {
				font-family: 'Times New Roman';
				height: 60px;
				line-height: 60px;
				text-align: center;

				/* Permalink - use to edit and share this gradient: https://colorzilla.com/gradient-editor/#1e5799+0,2989d8+50,207cca+51,7db9e8+100;Blue+Gloss+Default */
				background: linear-gradient(to bottom,  #1e5799 0%,#2989d8 50%,#207cca 51%,#7db9e8 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
			}
		</style>
	</head>
	<body>
		<div>
			<h1>CSS3 Gradient</h1>
		</div>
	</body>
</html>

```

그레이디언트를 구현하기 위해 사용되는 linear-gradient() 함수는 아래와 같은 형식으로 입력한다.

```bnf

linear-gradient(<각도>, <색상 블록 - 색상, 위치>, <색상 블록 - 색상, 위치>)

```

---

참고자료

#참고도서/모던_웹_디자인을_위한_HTML5_CSS3_입문 

---

