import botocore.exceptions


def listexc(mod):
    # module = __import__(mod)
    exc = []
    for name in botocore.exceptions.__dict__:
        if (isinstance(botocore.exceptions.__dict__[name], Exception) or
                name.endswith('Error')):
            exc.append(name)
    for name in exc:
        print('%s.%s is an exception type' % (str(mod), name))
    return


if __name__ == '__main__':
    import sys

    if len(sys.argv) <= 1:
        print('Give me a module name on the $PYTHONPATH!')
    print('Looking for exception types in module: %s' % sys.argv[1])
    listexc(sys.argv[1])
