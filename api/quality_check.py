import sys
import unittest


def run_test_in_dir(path):
    print('Running tests in ' + path)
    return unittest.TextTestRunner().run(unittest.TestLoader().discover(path))


if __name__ == '__main__':
    test_results = run_test_in_dir("tests")

    if test_results.errors or test_results.failures:

        # Tests failed, indicate this to process
        sys.exit(1)
