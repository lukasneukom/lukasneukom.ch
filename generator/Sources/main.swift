import Foundation
import Markdown

let source = """
# Lukas Neukom
Hallo Internet — Ich heisse Lukas und bin Bauingenieur.
Aktuell befinde ich mich in einer beruflichen Auszeit.
Zuvor war ich Projekt- und Bauleiter im Tiegbau bei der [Grob Ingenieure AG](https://grob.me).
Meine Hobbies sind lesen, schreiben, lernen, spielen und Sport.

Diese Seite ist von Hand mit HTML, CSS und einer Prise [Code Golf](https://code.golf) programmiert.
"""

let document = Document(parsing: source)
print(document.debugDescription())
