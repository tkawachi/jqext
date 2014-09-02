import jQuery.*;

using jqext.JQExt;

class TestMain {
  static function setupCollapse1() {
    var collapse = new JQuery("#clps1");
    collapse.toggleClassOnCollapse(new JQuery("#tgl1"));
  }

  static function setupCollapse2() {
    var collapse = new JQuery("#clps2");
    collapse.toggleClassOnCollapse(new JQuery("#tgl2"));
    collapse.on("hide.bs.collapse", function() {
      return false;
    });
  }

  static function setupCollapse3() {
    var collapse = new JQuery("#clps3");
    collapse.toggleClassOnCollapse(new JQuery("#tgl3"));
  }

  static function main() {
    new JQuery(function() {
      setupCollapse1();
      setupCollapse2();
      setupCollapse3();
    });
  }
}
