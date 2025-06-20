// main.go
package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func NewServer() *echo.Echo {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})
	return e
}

func main() {
	e := NewServer()
	e.Logger.Fatal(e.Start(":1323"))
}
