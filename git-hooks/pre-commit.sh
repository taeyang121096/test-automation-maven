#!/bin/bash
echo "===== Running Maven Tests Before Commit ====="

# index에 있는 변경사항만 테스트 실행 가능하게 임시로 저장
git stash -q --keep-index

# 테스트 실행
./mvnw test
RESULT=$?

# stash 복원
git stash pop -q

if [ $RESULT -ne 0 ]; then
  echo "❌ Tests failed. Commit aborted."
  exit 1
fi

echo "✅ Tests passed. Commit allowed."
exit 0
