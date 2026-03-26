```sh
sudo apt install trash-cli
sudo vi /usr/local/bin/rm
sudo chmod +x rm
```

```sh
#!/usr/bin/env bash
# /usr/local/bin/rm — trash-put 래퍼
# 모든 옵션(-r, -f, -rf 등)을 무시하고 대상 파일/디렉터리를 휴지통으로 이동

TARGETS=()

for arg in "$@"; do
    # - 로 시작하는 옵션은 전부 무시
    [[ "$arg" == -* ]] && continue
    TARGETS+=("$arg")
done

if [[ ${#TARGETS[@]} -eq 0 ]]; then
    echo "rm: 삭제할 대상이 없습니다." >&2
    exit 1
fi

exec trash-put "${TARGETS[@]}"
```
