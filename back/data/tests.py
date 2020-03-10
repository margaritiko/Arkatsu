from django.test import TestCase

from data.models import Sound


class SoundTests(TestCase):
    """Sound model tests."""

    def test_str(self):
        sound = Sound(temp=10, tone="C#", synthetic="S5")
        self.assertEquals(
            str(sound),
            '10 C# S5',
        )