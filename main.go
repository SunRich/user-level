package main

import (
	"git.apache.org/thrift.git/lib/go/thrift"
	"fmt"
	"crypto/tls"
	"time"
	"./service"
	"os"
	"accountlevel"
)

func init() {
	timelocal := time.FixedZone("CST", 3600*8) //设置时区
	time.Local = timelocal
}



func main() {
	var protocolFactory thrift.TProtocolFactory
	protocolFactory = thrift.NewTJSONProtocolFactory() //选择传输的格式
	var transportFactory thrift.TTransportFactory
	transportFactory = thrift.NewTTransportFactory()
	if err := runServer(transportFactory, protocolFactory, os.Getenv("ADDRESS"), false); err != nil {
		fmt.Println("error running server:", err)
	}

}

func runServer(transportFactory thrift.TTransportFactory, protocolFactory thrift.TProtocolFactory, addr string, secure bool) error {
	var transport thrift.TServerTransport
	var err error
	if secure {
		cfg := new(tls.Config)
		if cert, err := tls.LoadX509KeyPair("server.crt", "server.key"); err == nil {
			cfg.Certificates = append(cfg.Certificates, cert)
		} else {
			return err
		}
		transport, err = thrift.NewTSSLServerSocket(addr, cfg)
	} else {
		transport, err = thrift.NewTServerSocket(addr)
	}

	if err != nil {
		return err
	}
	fmt.Printf("%T\n", transport)
	handler :=&service.AccountLevel{}
	processor := accountlevel.NewAccountlevelProcessor(handler) //根据不同RPC服务不同步
	server := thrift.NewTSimpleServer4(processor,transport, transportFactory, protocolFactory)

	fmt.Println("Starting the simple server... on ", addr)
	return server.Serve()
}
