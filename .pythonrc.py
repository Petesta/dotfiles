import inspect

def print_class_methods(cls=None):
    if cls is None or not inspect.isclass(cls):
        print("Please provide a valid class.")
    elif not (methods := inspect.getmembers(cls, predicate=inspect.isfunction)):
        print(f"No methods found in class {cls.__name__}.")
    else:
        for name, func in methods:
            print(f"Method: {name}")
            print(f"  Docstring: {(doc := func.__doc__) or 'No docstring'}\n")

def print_class_ancestors(cls=None):
    if cls is None or not inspect.isclass(cls):
        print("Please provide a valid class.")
    else:
        mro = inspect.getmro(cls)
        if len(mro) <= 1:
            print(f"Class {cls.__name__} has no ancestors except Object.")
        else:
            for ancestor in mro[1:]:
                print(f"{ancestor.__name__}")
