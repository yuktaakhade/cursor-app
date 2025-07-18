from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.install_dependencies")
use_plugin("python.pytest")
use_plugin("python.pytest_coverage")

name = "cursor-app"
default_task = ["analyze", "run_unit_tests"]

@init
def set_properties(project):
    project.build_depends_on("Flask")
    project.build_depends_on("pytest")
    project.build_depends_on("pytest-cov")
    project.set_property("pytest_coverage_break_build", False)
    project.set_property("pytest_extra_args", ["--cov=.", "--cov-report=xml"]) 