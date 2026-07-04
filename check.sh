#!/bin/bash

for file in _posts/*.markdown; do
  # 1. 파일명에서 YYYY-MM-DD 추출
  file_date=$(basename "$file" | cut -d'-' -f1-3)
  
  # 2. 파일 내용에서 date 값 추출 (시간과 타임존 포함)
  # grep으로 date 라인을 찾고, cut으로 'date: ' 뒷부분을 가져옴
  content_date=$(grep "^date:" "$file" | sed 's/date: //')
  
  # 3. 내부 date 값에서 날짜 부분(YYYY-MM-DD)만 추출
  content_ymd=$(echo "$content_date" | cut -d' ' -f1)
  
  # 4. 비교
  if [ "$file_date" != "$content_ymd" ]; then
    echo "불일치 발견: $file"
    echo "  - 파일명 날짜: $file_date"
    echo "  - 내용 날짜: $content_ymd"
  fi
done