from factory import Sequence, SubFactory
from factory.django import DjangoModelFactory
%%DJANGO_RELEVANT_IMPORTS%%

class %%INSERT%%Factory(DjangoModelFactory):

    FACTORY_FOR = models.ModelName

    field_name = Sequence(lambda n: 'Name {0}'.format(n))
    related_instance = SubFactory(OtherFactory)
