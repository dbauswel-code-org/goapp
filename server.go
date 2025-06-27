// main.go
package main

import (
	"fmt"
	"net/http"

	"github.com/caarlos0/env"
	"github.com/labstack/echo/v4"
)

type TestConfig struct {
	Foo       string `env:"FOO" envDefault:"NOT_SET"`
	FooSecret string `env:"FOO_SECRET" envDefault:"NOT_SET"`
}

func NewServer() (*echo.Echo, error) {
	config := TestConfig{}
	err := env.Parse(&config)
	if err != nil {
		return nil, fmt.Errorf("failed to load Config: %v", err)
	}
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		msg := fmt.Sprintf("ENV VAR: %v\nSECRET VAR_Update1: %v \n", config.Foo, config.FooSecret)
		return c.String(http.StatusOK, msg)
	})
	return e, nil
}

func main() {
	e, err := NewServer()
	if err != nil {
		fmt.Println(err)
		e.Logger.Fatal()
	}
	e.Logger.Fatal(e.Start(":1323"))
}
