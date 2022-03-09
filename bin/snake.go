package main

import (
    "flag"
    "fmt"
    "strings"
)

func main() {
  flag.Parse()
  //fmt.Println(flag.Args())
  var args = flag.Args()
  var masterString = args[0]
  //fmt.Println("args = ", masterString)

  result := CamelToSnake(masterString)
  result2 := strings.Replace(result, "._", "_", -1)
  result3 := strings.Replace(result2, ".", "_", -1)

  //result := strings.ToLower(string)
  fmt.Println(result3)


}



func CamelToSnake(s string) string {
    if s == "" {
        return s
    }

    delimiter := "_"
    sLen := len(s)
    var snake string
    for i, current := range s {
        if i > 0 && i+1 < sLen {
            if current >= 'A' && current <= 'Z' {
                next := s[i+1]
                prev := s[i-1]
                if (next >= 'a' && next <= 'z') || (prev >= 'a' && prev <= 'z') {
                    snake += delimiter
                }
            }
        }
        snake += string(current)
    }

    snake = strings.ToLower(snake)
    return snake
}
