# KLua-String
A Korean string library for lua<br>
Lua를 위한 한국어 지원 라이브러리

KLua-String은 Lua에서 지원하지 않는 한글 관련 string 함수들을 제공합니다.<br>
찾기, 바꾸기 등의 기본적인 기능은 utf8( https://github.com/Stepets/utf8.lua )에 기반하였으며, KLua 라이브러리를 로드한 뒤 똑같은 함수명을 지정하여 사용할 수 있습니다.<br>
그 외에 현재 개발된 기능은 아래와 같습니다.<br>

#### 구현된 함수들
- KLua.merge(초,중,종성 데이터)
- KLua.exists(원본String, 초성)

#### 사용 방법

###### KLua 라이브러리 불러오기
- KLua는 일반적인 Lua 모듈과 같이 require으로 사용할 수 있습니다.
```lua
local KLua = require("KLua")
```

###### 초성, 중성, 종성을 기입하여 유니코드 한글 자모음 조립하기
- KLua의 merge 함수를 사용하여 한글 자모음을 조합할 수 있습니다.
- 사용 방법에 대한 예시는 아래와 같습니다.
```lua
KLua.merge({"ㅁ", "ㅣ", "ㅋ"}) --밐
```
- 또한, 종성을 기입하지 않고 초, 중성만 기입하여 자모음을 조립할 수도 있습니다.
```lua
KLua.merge({"ㅁ", "ㅣ"}) --미
```
- merge 함수의 반환값은 조립된 낱말입니다.

###### 유니코드 한글 자모음을 초성, 중성, 종성으로 분리하기
- KLua의 split 함수를 사용하여 한글 자모음을 분해할 수 있습니다.
- 사용 방법에 대한 예시는 아래와 같습니다.
```lua
KLua.split("카가미네 린 최고!!")
-- {{"ㅋ", "ㅏ"}, {"ㄱ", "ㅏ"}, {"ㅁ", "ㅣ"}, {"ㄴ", "ㅔ"}, {" "}, {"ㄹ", "ㅣ", "ㄴ"}, {" "}, {"ㅊ", "ㅚ"}, {"ㄱ", "ㅗ"}, {"!"}, {"!"}}
```
- split 함수의 반환값은 분리된 낱말 및 문자의 table입니다.

###### 초성 검색하기
- KLua의 exists 함수를 사용하여 초성 검색을 할 수 있습니다.
- 초성이 아닌 완성된 낱말이나 영어등을 기입할경우 utf8에서 제공하는 find 기능을 이용하여 존재 여부를 boolean으로 반환합니다.
```lua
KLua.exists("미쿠의 머리카락은 정말 길어서 바닥에 쓸릴 것 같아", "ㅎ") -- false
KLua.exists("미쿠의 머리카락은 정말 길어서 바닥에 쓸릴 것 같아", "ㅋ") -- true
KLua.exists("미쿠의 머리카락은 정말 길어서 바닥에 쓸릴 것 같아", "미쿠") -- true
KLua.exists("Hatsune Miku", "M") -- true
```

개발자
----
`이호원 (Howon Lee) a.k.a hoyo321 or kck4156, airtaxi`

라이센스
----
Apache License Version 2.0