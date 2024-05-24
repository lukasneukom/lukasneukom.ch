import Foundation
import Markdown

// Get markdown files
let path = "/Users/lukasneukom/Websites/lukasneukom.ch"

var manager = FileManager.default
manager.changeCurrentDirectoryPath(path)

var enumerator = manager.enumerator(atPath: "\(path)/pages")
while let page = enumerator?.nextObject() as? String {
    if page.hasSuffix(".md") {
        do {
            let document = try String(contentsOfFile: "\(path)/pages/\(page)")
            print("Reading \(page) ...\n====================\n\(document)\n====================\n")
        } catch {
            print("Could not read file named \(page)")
        }
    }
}

// Split meta and content
// Extract meta information
// Convert markdown to html
// Put sites together

//let source = """
//# Lukas Neukom
//Hallo Internet — Ich heisse Lukas und bin Bauingenieur.
//Aktuell befinde ich mich in einer beruflichen Auszeit.
//Zuvor war ich Projekt- und Bauleiter im Tiefbau bei der [Grob Ingenieure AG](https://grob.me).
//Meine Hobbies sind lesen, schreiben, lernen, spielen und Sport.
//
//Diese Seite ist von Hand mit HTML, CSS und einer Prise [Code Golf](https://code.golf) programmiert.
//"""
//
//let document = Document(parsing: source)
//print(document.debugDescription())

struct MarkdownToHTML: MarkupVisitor {
    mutating func defaultVisit(_ markup: Markup) -> String {
        var html = ""
        
        for child in markup.children {
            html += visit(child)
        }
        
        return html
    }
    
    mutating func visitHeading(_ heading: Heading) -> String {
        var title = ""
        
        for child in heading.children {
            title += visit(child)
        }
        
        return "<h\(heading.level)>\(title)</h\(heading.level)>"
    }
    
    mutating func visitParagraph(_ paragraph: Paragraph) -> String {
        var html = "\n\n<p> "
        
        for child in paragraph.children {
            html += visit(child)
        }
        
        return html
    }
    
    func visitText(_ text: Text) -> String {
        text.plainText
    }
    
    func visitSoftBreak(_ softBreak: SoftBreak) -> String {
        "\n    "
    }
    
    mutating func visitLink(_ link: Link) -> String {
        var html = "<a href=\(link.destination ?? "#")>"
        
        for child in link.children {
            html += visit(child)
        }
        
        html += "</a>"
        return html
    }
}

//var htmlGenerator = MarkdownToHTML()
//let html = htmlGenerator.visit(document)
//print(html)
