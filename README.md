#.wslconfig
- home 디렉토리에 놓을 것
- wsl shutdown 후 재시작 해야 적용됨
- wsl 재접속 후 free, top 등을 활용하여 메모리 확인

```console
$ wsl --shutdown
```

#wsl-networks.ps1
- wsl 에서 사용되는 포트와 호스트(로컬 pc)의 포트포워딩을 해주며, 외부로 포트를 열어줌
- $ports 부분에 포트포워딩 할 포트들 나열 할 것

#wsl-service.bat
- 윈도우 구동시 자동으로 wsl 서비스들 실행 및 포트포워딩 가능하도록 하는 bat 파일
- 윈도우 스케줄러에 등록 할 것
> 트리거 : 로그온할 때
> 동작 : 프로그램 시작
