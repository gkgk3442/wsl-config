# wsl ?

WSL 2는 Linux용 Windows 하위 시스템 아키텍처의 새로운 버전으로, Linux용 Windows 하위 시스템이 Windows에서 ELF64 Linux 이진 파일을 실행할 수 있게 해줍니다. WSL 2의 주 목표는 파일 시스템 성능을 높이고전체 시스템 호출 호환성을 추가하는 것입니다.

이 새 아키텍처는 이러한 Linux 이진 파일이 Windows 및 컴퓨터의 하드웨어와 상호 작용하는 방식을 변경하되, WSL 1(현재 널리 사용 가능한 버전)과 동일한 사용자 환경을 제공합니다.

개별 Linux 배포는 WSL 1 또는 WSL 2 아키텍처를 사용하여 실행할 수 있습니다. 언제든지 각 배포를 업그레이드하거나 다운그레이드할 수 있으며 WSL 1 및 WSL 2 배포를 함께 실행할 수 있습니다. WSL 2는 실제 Linux 커널을 실행하는 이점을 제공하는 완전히 새로운 아키텍처를 사용합니다.

## WSL 설치
```bash
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

```bash
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

```bash
wsl --set-default-version 2
```

## sudo 권한

```bash
$ sudo visudo
> shinssy ALL=NOPASSWD: /usr/sbin/service,/usr/bin/systemctl,/usr/bin/docker
or
> shinssy ALL=NOPASSWD: ALL
```

## 윈도우 파일 탐색기로 열기

- start 파일 참고

```console
$ mkdir ~/.local/bin
~/.local/bin/start 위치 시킬 것

$ chmod 755 start

$ source ~/.profile
$ start
명령어 실행 시 현재 위치, 윈도우 파일 탐색기로 열림
```

## 개발 환경 설치 파일

### net-tools

```console
$ sudo apt install net-tools
```

### openssh

```console
sudo apt update
sudo apt install openssh-server
sudo vi /etc/ssh/sshd_config
PasswordAuthentication yes
sudo service ssh start
```

### git

```console
sudo apt install git
git --version
git config --global credential.helper 'store --file ~/.git-credentials'
git config --global user.name shinssy
git config --global user.email test@test.com
git config --global http.sslVerify false
```

### docker

```console
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo service docker start
sudo docker ps
```

### java

> zulujdk 설치

```console
sudo apt update
sudo apt -y install gnupg curl
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
sudo apt install ./zulu-repo_1.0.0-3_all.deb
sudo apt update
apt search zulu
sudo apt install zulu17-jdk
java --version
```

> 여러 버전이 설치된 경우, java 버전 변경

```console
$ sudo update-alternatives --config java
```

### node lts

```console
$ sudo apt update
$ curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
$ sudo apt install nodejs
```

# .wslconfig

> .wslconfig 를 사용하여 WSL 2에서 실행되는 모든 설치된 배포판에서 전역적으로 설정 가능

- home 디렉토리에 놓을 것
- wsl shutdown 후 재시작 해야 적용됨
- wsl 재접속 후 free, top 등을 활용하여 메모리 확인

```console
$ wsl --shutdown
```

# wsl-init.ps1

> wsl 에서 사용되는 포트와 호스트(로컬 pc)의 포트포워딩을 해주며, 외부로 포트를 열어줌  
> $ports 부분에 포트포워딩 할 포트들 나열 할 것


# ~~~wsl-networks.ps1~~~

> wsl 에서 사용되는 포트와 호스트(로컬 pc)의 포트포워딩을 해주며, 외부로 포트를 열어줌  
> $ports 부분에 포트포워딩 할 포트들 나열 할 것

# ~~~wsl-service.bat~~~

> 윈도우 구동시 자동으로 wsl 서비스들 실행 및 포트포워딩 가능하도록 하는 bat 파일  
> 윈도우 스케줄러에 등록 할 것

- 트리거 : 로그온할 때
- 동작 : 프로그램 시작
