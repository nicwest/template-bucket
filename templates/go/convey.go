package %%DIRNAME%%

import (
	. "github.com/smartystreets/goconvey/convey"
	"testing"
)

func TestFunction(t *testing.T) {
	Convey("Given a thing", t, func() {
		thing := "thing"
		Convey("When I do things to it", func () {
			thing = thing + "asdas"
			Convey("Then the thing should be different", func () {
				So(thing, ShouldEqual, "thingasdas")
			})
		})
	})
}
