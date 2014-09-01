import massive.munit.util.Timer;
import massive.munit.Assert.*;
import massive.munit.async.AsyncFactory;

import haxe.ds.Option;
import jQuery.*;

using jqext.JQExt;

class JQExtTest {
  public function new() {}

  public function justEnsureCompiling() {
    new JQuery("body").findOne(".test-find-one");
  }
}
