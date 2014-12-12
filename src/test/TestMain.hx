import jQuery.*;

using jqext.JQExt;

class TestMain {
  static function setupCollapse1() {
    var collapse = new JQuery("#clps1");
    collapse.toggleClassOnCollapse(
        new JQuery("#tgl1"), "glyphicon-chevron-down", "glyphicon-chevron-up"
      );
  }

  static function setupCollapse2() {
    var collapse = new JQuery("#clps2");
    collapse.toggleClassOnCollapse(
      new JQuery("#tgl2"), "glyphicon-chevron-down", "glyphicon-chevron-up"
    );
    collapse.on("hide.bs.collapse", function() {
      return false;
    });
  }

  static function main() {
    new JQuery(function() {
      setupCollapse1();
      setupCollapse2();
    });
  }
}
