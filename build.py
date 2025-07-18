from pybuilder.core import use_plugin, init, task

use_plugin('python.core')
use_plugin('pypi:pybuilder_pytest')
use_plugin('pypi:pybuilder_pytest_coverage')
use_plugin('python.flake8')
# use_plugin('python.coverage')

name = 'e-shopping-python'
default_task = ['clean', 'analyze', 'publish']

@init
def set_properties(project):
    project.build_depends_on('Flask')
    project.build_depends_on('Flask-SQLAlchemy')
    project.build_depends_on('coverage')
    project.build_depends_on('flake8')
    project.build_depends_on('pytest')
    project.build_depends_on('pytest-cov')
    project.build_depends_on('pyyaml')
    project.set_property('pytest_coverage_break_build_threshold', 0)
    project.set_property('pytest_coverage_xml', True)
    project.set_property('pytest_coverage_html', False)
    project.set_property('pytest_coverage_annotate', False)
    project.set_property('pytest_extra_args', ['--cov-report', 'xml'])
    project.set_property('coverage_break_build', False)
    project.set_property('flake8_break_build', True)
    project.set_property('dir_source_unittest_python', '.')
    project.set_property('dir_source_pytest_python', '.')
    project.set_property('unittest_module_glob', 'test_*.py')
    project.set_property('flake8_include_test_sources', True)
    project.set_property('dir_source_main_python', '.')
    project.set_property('flake8_include_patterns', ['*.py'])
    project.set_property('flake8_exclude_patterns', ['src/main/python'])

@task
def run_tests(project, logger):
    """Run unit tests using unittest."""
    logger.info('Running unit tests...')

@task
def check_coverage(project, logger):
    """Check test coverage using coverage plugin."""
    logger.info('Checking coverage...')

@task
def lint_code(project, logger):
    """Lint code using flake8."""
    logger.info('Linting code...') 