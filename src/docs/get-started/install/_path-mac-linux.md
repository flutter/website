### Path 추가

[Flutter SDK 다운로드](#get-sdk)에 나와있는 방법은 커멘드라인의 현재 세션에 대해서만 PATH 변수를 추가합니다.
`flutter` 명령을 모든 터미널 세션에서 실행하기 위해서 영구적으로 PATH 변수를 추가할 필요가 있을 것입니다.

이 단계는 모든 터미널 세션에 대해 변수를 영구적으로 추가하는 방법은 시스템마다 다릅니다.
일반적으로 새 창을 열 때마다 실행되는 파일에 한 줄을 추가합니다.
예시: 

 1. Flutter SDK가 위치한 디렉토리를 정하세요. 3번째 단계에서 이것을 활용합니다.
 2. `$HOME/.bash_profile`를 여세요(없으면 생성하세요).
    파일 경로와 파일 이름은 시스템에 따라 다를 수 있습니다. 
 3. 아래 한 줄을 추가한 후 `[PATH_TO_FLUTTER_GIT_DIRECTORY]`를 Flutter 깃 레포지토리를 복제한 위치로 변경하세요. 
 
    ```terminal
    $ export PATH="$PATH:[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin"
    ```

 4. 현재 창에 적용하기 위해 `source $HOME/.bash_profile`를 실행하세요.
 5. 이제 아래 명령을 실행하여 PATH에 `flutter/bin`이 있는지 검증하세요. 
 
    ```terminal
    $ echo $PATH
    ```

자세한 정보를 알고싶으시면, 
[StackExchange 질문](https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path)을 참조하세요.
