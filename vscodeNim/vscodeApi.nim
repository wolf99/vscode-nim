import jsffi
export jsffi
import jsPromise
export jsPromise
import jsre

## TODO: Move from JsObject to JsRoot for more explict errors

type
    VscodeDocumentFilter* = ref VscodeDocumentFilterObj
    VscodeDocumentFilterObj {.importc.} = object of JsObject
        language*:cstring
        scheme*:cstring

type
    VscodeMarkdownString* = ref VscodeMarkdownStringObj
    VscodeMarkdownStringObj {.importc.} = object of JsObject
        value*:cstring

type
    VscodeUri* = ref VscodeUriObj
    VscodeUriObj {.importc.} = object of JsObject
        fsPath*:cstring

type
    VscodeTextLine* = ref VscodeTextLineObj
    VscodeTextLineObj {.importc.} = object of JsObject
        text*:cstring

type
    VscodeTextDocument* = ref VscodeTextDocumentObj
    VscodeTextDocumentObj {.importc.} = object of JsRoot
        fileName*:cstring

type
    VscodePosition* = ref VscodePositionObj
    VscodePositionObj {.importc.} = object of JsObject
        line*: cint
        character*: cint

type
    VscodeRange* = ref VscodeRangeObj
    VscodeRangeObj {.importc.} = object of JsObject
        start*:VscodePosition
        `end`*:VscodePosition

type
    VscodeCancellationToken* = ref VscodeCancellationTokenObj
    VscodeCancellationTokenObj {.importc.} = object of JsObject

type VscodeHoverLabel* = ref object
    # Not explictly named in vscode API, see type literal under MarkedString
    language*:cstring
    value*:cstring

type
    VscodeMarkedString* = ref VscodeMarkedStringObj
    VscodeMarkedStringObj {.importc.} = object of JsObject
proc cstringToMarkedString(s:cstring):VscodeMarkedString {.importcpp:"#".}
converter toVscodeMarkedString*(s:cstring):VscodeMarkedString = s.cstringToMarkedString()
proc hoverLabelToMarkedString(s:VscodeHoverLabel):VscodeMarkedString {.importcpp:"#".}
converter toVscodeMarkedString*(s:VscodeHoverLabel):VscodeMarkedString = s.hoverLabelToMarkedString()
proc markdownStringToMarkedString(s:VscodeMarkdownString):VscodeMarkedString {.importcpp:"#".}
converter toVscodeMarkedString*(s:VscodeMarkdownString):VscodeMarkedString = s.markdownStringToMarkedString()

type
    VscodeHover* = ref VscodeHoverObj
    VscodeHoverObj {.importc.} = object of JsObject
        contents*:seq[VscodeMarkedString]
        `range`*:VscodeRange

type
    VscodeSymbolInformation* = ref VscodeSymbolInformationObj
    VscodeSymbolInformationObj {.importc.} = object of JsObject

type
    VscodeFormattingOptions* = ref VscodeFormattingOptionsObj
    VscodeFormattingOptionsObj {.importc.} = object of JsObject

type
    VscodeParameterInformation* = ref VscodeParameterInformationObj
    VscodeParameterInformationObj {.importc.} = object of JsObject

type
    VscodeSignatureInformation* = ref VscodeSignatureInformationObj
    VscodeSignatureInformationObj {.importc.} = object of JsObject
        parameters*:seq[VscodeParameterInformation]

type
    VscodeSignatureHelp* = ref VscodeSignatureHelpObj
    VscodeSignatureHelpObj {.importc.} = object of JsObject
        signatures*:seq[VscodeSignatureInformation]
        activeSignature*:cint
        activeParameter*:cint

type
    VscodeWorkspace* = ref VscodeWorkspaceObj
    VscodeWorkspaceObj {.importc.} = object of JsObject
        rootPath*:cstring

type
    VscodeConfigurationChangeEvent* = VscodeConfigurationChangeEventObj
    VscodeConfigurationChangeEventObj {.importc.} = object of JsRoot

type
    VscodeWorkspaceConfiguration* = ref VscodeWorkspaceConfigurationObj
    VscodeWorkspaceConfigurationObj {.importc.} = object of JsObject

type
    VscodeWorkspaceFolder* = ref VscodeWorkspaceFolderObj
    VscodeWorkspaceFolderObj {.importc.} = object of JsObject
        uri*:VscodeUri

type
    VscodeCompletionItem* = ref VscodeCompletionItemObj
    VscodeCompletionItemObj {.importc.} = object of JsObject
        detail*:cstring
        sortText*:cstring
        documentation*:cstring
        documentationMD* {.importcpp: "documentation".}:VscodeMarkdownString

type
    VscodeTextEdit* = ref VscodeTextEditObj
    VscodeTextEditObj {.importc.} = object of JsObject

type
    VscodeReferenceContext* = ref VscodeReferenceContextObj
    VscodeReferenceContextObj {.importc.} = object of JsObject
        includeDeclaration*:bool

type
    VscodeDefinition* = ref VscodeDefinitionObj
    VscodeDefinitionObj {.importc.} = object of JsObject

type
    VscodeDefinitionLink* = ref VscodeDefinitionLinkObj
    VscodeDefinitionLinkObj {.importc.} = object of JsObject

type VscodeProviderResult* = VscodeDefinition or openArray[VscodeDefinitionLink]

type
    VscodeLocation* = ref VscodeLocationObj
    VscodeLocationObj {.importc.} = object of JsObject

type
    VscodeWorkspaceEdit* = ref VscodeWorkspaceEditObj
    VscodeWorkspaceEditObj {.importc.} = object of JsObject

type
    VscodeTerminal* = ref VscodeTerminalObj
    VscodeTerminalObj {.importc.} = object of JsObject

type
    VscodeSelection* = ref VscodeSelectionObj
    VscodeSelectionObj {.importc.} = object of VscodeRange

type
    VscodeTextEditor* = ref VscodeTextEditorObj
    VscodeTextEditorObj {.importc.} = object of JsObject
        document*:VscodeTextDocument
        selection*:VscodeSelection

type
    VscodeWindow* = ref VscodeWindowObj
    VscodeWindowObj {.importc.} = object of JsObject
        activeTextEditor*:VscodeTextEditor

type
    VscodeDisposable* = ref VscodeDisposableObj
    VscodeDisposableObj {.importc.} = object of JsObject

type
    VscodeCommands* = ref VscodeCommandsObj
    VscodeCommandsObj {.importc.} = object of JsObject
        registerCommand*: proc(name:cstring, cmd:proc()):VscodeDisposable {.closure.}

type VscodeCompletionKind* {.nodecl.} = enum
    text = 0
    `method` = 1
    function = 2
    constructor = 3
    field = 4
    variable = 5
    class = 6
    `interface` = 7
    module = 8
    property = 9
    unit = 10
    value = 11
    `enum` = 12
    keyword = 13
    snippet = 14
    color = 15
    file = 16
    reference = 17
    folder = 18
    enumMember = 19
    constant = 20
    struct = 21
    event = 22
    operator = 23
    typeParameter = 24

type
    Vscode* = ref VscodeObj
    VscodeObj {.importc.} = object of JsObject
        window*: VscodeWindow
        commands*: VscodeCommands
        workspace*: VscodeWorkspace
proc newWorkspaceEdit*(vscode:Vscode):VscodeWorkspaceEdit {.importcpp: "(new #.WorkspaceEdit(@))".}
proc newPosition*(vscode:Vscode, start:cint, `end`:cint):VscodePosition {.importcpp: "(new #.Position(@))".}
proc newRange*(vscode:Vscode, start:VscodePosition, `end`:VscodePosition):VscodeRange {.importcpp: "(new #.Range(@))".}
proc newCompletionItem*(vscode:Vscode, name:cstring, kind:VscodeCompletionKind):VscodeCompletionItem {.importcpp: "(new #.CompletionItem(@))".}
proc newMarkdownString*(vscode:Vscode, text:cstring):VscodeMarkdownString {.importcpp: "(new #.MarkdownString(@))".}
proc newSignatureHelp*(vscode:Vscode):VscodeSignatureHelp {.importcpp: "(new #.SignatureHelp(@))".}
proc newSignatureInformation*(vscode:Vscode, kind:cstring, docString:cstring):VscodeSignatureInformation {.importcpp: "(new #.SignatureInformation(@))".}
proc newParameterInformation*(vscode:Vscode, name:cstring):VscodeParameterInformation {.importcpp: "(new #.ParameterInformation(@))".}
proc newVscodeHover*(vscode:Vscode, contents:VscodeMarkedString):VscodeHover {.importcpp: "(new #.Hover(@))".}
proc newVscodeHover*(vscode:Vscode, contents:seq[VscodeMarkedString]):VscodeHover {.importcpp: "(new #.Hover(@))".}
proc newVscodeHover*(vscode:Vscode, contents:VscodeMarkedString, `range`:VscodeRange):VscodeHover {.importcpp: "(new #.Hover(@))".}
proc newVscodeHover*(vscode:Vscode, contents:seq[VscodeMarkedString], `range`:VscodeRange):VscodeHover {.importcpp: "(new #.Hover(@))".}

# Output
proc showInformationMessage*(win:VscodeWindow, msg:cstring) {.importcpp.}
    ## shows an informational message

# Workspace
proc saveAll*(workspace:VscodeWorkspace, includeUntitledFile:bool):Promise[bool] {.importcpp.}
proc getConfiguration*(workspace:VscodeWorkspace):VscodeWorkspaceConfiguration {.importcpp.}
proc onDidChangeConfiguration*(workspace:VscodeWorkspace, cb:proc(e:VscodeConfigurationChangeEvent):void):VscodeDisposable {.importcpp.}

# Window
proc createTerminal*(window:VscodeWindow, name:cstring):VscodeTerminal {.importcpp.}

# Terminal
proc sendText*(term:VscodeTerminal, name:cstring):void {.importcpp.}

# Document
proc lineAt*(doc:VscodeTextDocument, position:VscodePosition):VscodeTextLine {.importcpp.}
proc getText*(doc:VscodeTextDocument):cstring {.importcpp.}
proc getText*(doc:VscodeTextDocument, `range`:VscodeRange):cstring {.importcpp.}
proc getWordRangeAtPosition*(doc:VscodeTextDocument, position:VscodePosition):VscodeRange {.importcpp.}
proc getWordRangeAtPosition*(doc:VscodeTextDocument, position:VscodePosition, regex:RegExp):VscodeRange {.importcpp.}
proc validateRange*(doc:VscodeTextDocument, `range`:VscodeRange):VscodeRange {.importcpp.}

# Range
proc with*(
    `range`:VscodeRange,
    start:VscodePosition = nil,
    `end`:VscodePosition = nil
):VscodeRange {.importcpp: "#.with({start:#, end:#})".}

# TextEdit

## static function, but the import in js is "dynamic" in the variable it's assigned to
proc textEditReplace*(vscode:Vscode, `range`:VscodeRange, content:cstring):VscodeTextEdit {.importcpp: "#.TextEdit.replace(@)".}

# Events

proc affectsConfiguration*(event:VscodeConfigurationChangeEvent, section:cstring):bool {.importcpp.}

var vscode*:Vscode = require("vscode").to(Vscode)

## References / Helpful Links
## 
## Union types for function input params arguments: https://forum.nim-lang.org/t/1628
## Nim ES2015 class macros: https://github.com/kristianmandrup/nim_es2015_classes/blob/master/src/es_class.nim