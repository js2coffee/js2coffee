/* eslint-disable max-len */
import { Node, BaseNode, Program } from "estree";
import { CodeWithSourceMap } from "source-map";

type IObject = Record<string, unknown>;

/**
 * ESTree node types for CoffeeScript AST nodes in `IJS2CoffeeAST` body.
 *
 * @type {string} String prefixed with `"Coffee"`.
 */
export type CoffeeNodeType = (
	"CoffeeDoExpression"
	| "CoffeeEscapedExpression"
	| "CoffeeListExpression"
	| "CoffeeLoopStatement"
	| "CoffeePrototypeExpression"
);

/**
 * Custom ESTree-style node used to define CoffeeScript in JS2Coffee ASTs.
 *
 * @extends {estree.Node}
 * @member {CoffeeNodeType} type ESTree node types for CoffeeScript AST nodes.
 */
export interface JS2CoffeeCustomNode extends Omit<Node, "type"> {
	type: CoffeeNodeType;
}

/**
 * Custom ESTree-style node used to define converted CoffeeScript nodes JS2Coffee ASTs.
 *
 * @extends {estree.Node}
 * @member {CoffeeNodeType} type ESTree node types for JavaScript or CoffeeScript AST nodes.
 */
export interface CoffeeNode extends Omit<Node, "type"> {
	type: Node["type"] | CoffeeNodeType;
}

/**
 * Generic compilation error in JS2Coffee.
 *
 * @member description Error description message.
 * @member end Error end position.
 * @member end.line Error end line number.
 * @member start Error start position.
 * @member start.line Error start line number.
 */
export interface IJS2CoffeeError extends Error {
	description: string;
	end: {
		line: number;
		column: number;
	};
	start: {
		line: number;
		column: number;
	};
}

/**
 * Esprima-style error thrown by JS2Coffee.
 *
 * @member column Error column number.
 * @member description Error description message.
 * @member lineNumber Error line number.
 */
export interface IJS2CoffeeEsprimaStyleError {
	column: number;
	description: string;
	lineNumber: number;
}

/**
 * JavaScript syntax error thrown by JS2Coffee compiler.
 *
 * @extends IJS2CoffeeError
 * @member filename File name for syntax error.
 * @member js2coffee Whether this error is thrown by JS2Coffee - always true.
 * @member sourcePreview Array of source code lines containing error.
 */
export interface IJS2CoffeeSyntaxProblem extends IJS2CoffeeError {
	filename: string;
	js2coffee: true;
	sourcePreview: string[];
}

/**
 * Collection of helper functions used to parse JavaScript in JS2Coffee.
 */
export interface IJS2CoffeeHelpers {
	/**
	 * Reserved words taken from COFFEE_KEYWORDS (lexer.coffee).
	 * We don't check for "undefined" because it"s already explicitly
	 * accounted for elsewhere.
	 */
	reserved: {
		keywords: string[];
		reserved: string[];
		aliases: string[];
	};
	reservedWords: string[];
	/**
	 * Builds a syntax error message.
	 *
	 * @param err Error to convert into syntax error.
	 * @param source Source code that threw the JS2Coffee compiler error
	 * @param file File name including extension.
	 */
	buildError(
		err: IJS2CoffeeError | IJS2CoffeeEsprimaStyleError,
		source: string,
		file: string
	): IJS2CoffeeSyntaxProblem;
	/**
	 * Duplicates all primitive members of an object recursively.
	 *
	 * @param {object} obj Object to clone.
	 * @returns Deep copy of object.
	 */
	clone(obj: IObject): IObject;
	/**
	 * Turns an array of strings into a comma-separated list.
	 * Takes new lines into account.
	 *
	 * @param list Array of elements to join with `,`.
	 * @returns Array with elements separated by `,`.
	 */
	commaDelimit(list: string[]): string[];
	/**
	 * Intersperses `joiner` into `list`.
	 * Used for things like adding indentations.
	 *
	 * @param list Array of elements to be joined by `joiner`.
	 * @param joiner Element to insert between each element of `list`.
	 */
	delimit(list: any[], joiner: any): any[];
	/**
	 * Escapes JS that cannot be converted to CoffeeScript.
	 *
	 * @param {Node} node Unconvertable node.
	 * @returns {CoffeeNode} Node with type "CoffeeEscapedExpression".
	 */
	escapeJs(node: Node): CoffeeNode;
	/**
	 * Inspect a ESTree node for debugging.
	 *
	 * @param node Node to inspect.
	 * @returns String representation bounded by `~~~~`.
	 */
	inspect(node: BaseNode): `~~~~\n${string}\n~~~~`;
	/**
	 * ESTree comment node assertion.
	 *
	 * @param {BaseNode} node Node to apply test to.
	 * @returns {boolean} Whether the ESTree node is a comment.
	 */
	isComment(node: BaseNode): boolean;
	/**
	 * ESTree infinite loop node assertion.
	 *
	 * @param {BaseNode} node Node to apply test to.
	 * @returns {boolean} Whether the ESTree node is a infinite loop.
	 */
	isLoop(node: BaseNode): boolean;
	/**
	 * ESTree 'truthy" node assertion.
	 * A node is truthy when it has a "Literal" type and a value.
	 *
	 * @param {BaseNode} node Node to apply test to.
	 * @returns {boolean} Whether the ESTree node is a 'truthy" node.
	 */
	isTruthy(node: BaseNode): boolean;
	/**
	 * Returns the final return statements in a body.
	 *
	 * @param body AST colleciton of nodes describing a program.
	 * @returns Array of ESTree nodes for final return statement or empty array.
	 */
	getReturnStatements(body: BaseNode[]): BaseNode[] | [];
	/**
	 * Returns the precedence level of a ESTree operator node.
	 * If a node"s precedence level is greater than its parent, it has to be
	 * parenthesized.
	 *
	 * @param node ESTree operator node.
	 * @returns Precedence level.
	 */
	getPrecedence(node: BaseNode): number;
	joinLines(props: string[], indent: string): string[];
	/**
	 * Get the last statement in a program.
	 *
	 * @param body AST colleciton of nodes describing a program.
	 * @returns Last non-comment node in a program.
	 */
	lastStatement(body: BaseNode[]): BaseNode;
	/**
	 * Appends a new line to a given SourceNode (what `walk()` returns). If it
	 * already ends in a newline, it is left alone.
	 *
	 * @param srcnode Either a ESTree node or a node array terminating with `\n`.
	 * @returns ESTree node array terminating with `\n`.
	 */
	newline(srcnode: BaseNode | [BaseNode, "\n"]): [BaseNode, "\n"];
	/**
	 * Get the next ESTree node after `node` that is not a comment
	 *
	 * @param body AST colleciton of nodes describing a program.
	 * @param node Current node in JS2Coffee stack.
	 * @returns Next non-comment stack, if one is available.
	 */
	nextNonComment(body: BaseNode[], node: BaseNode): BaseNode | undefined;
	/**
	 * Iterate to the next ESTree node until `fn` returns true.
	 *
	 * @param body AST colleciton of nodes describing a program.
	 * @param node Current node in JS2Coffee stack.
	 * @returns Next ESTree node that passes the `fn` callback.
	 */
	nextUntil(body: BaseNode[], node: BaseNode, fn: (n: BaseNode) => boolean): BaseNode | undefined;
	/**
	 * Prepends every item in the `list` with a given `prefix`.
	 *
	 * @param list Array of elements.
	 * @param prefix Prefix to insert before every element.
	 * @returns Array with all elements preceded by `prefix`.
	 */
	 prependAll(list: any[], prefix: any): any[];
	/**
	 * Quotes a string or primitive with single quotes.
	 *
	 * @param {any} str String to quote.
	 */
	quote(str: any): string;
	/**
	 * Fabricates a replacement node for `node` that maintains the same source
	 * location.
	 *
	 * @param node Prevous node.
	 * @param {SourceLocation} node.loc Previous node"s location (preserved in output).
	 * @param {number[]} node.range Previous node"s character range (preserved in output).
	 * @param newNode New ESTree node with a specified `type` and `name`.
	 * @param {string} newNode.type ESTree or JS2Coffee type for the new node.
	 * @param {string} newNode.name Name of the new node.
	 * @returns Newly typed and named node with previous source location.
	 */
	replace(node: BaseNode, newNode: BaseNode): BaseNode;
	/**
	 * Delimit using spaces. This also accounts for times where one of the
	 * statements begin with a new line, such as in the case of function
	 * expressions and object expressions.
	 *
	 * @param {string[]} list Array of code tokens.
	 * @returns Array of code tokens separated by spaces.
	 */
	space(list: string[]): string[];
	/**
	 * Convert identifier, custom character or indentation level into indent.
	 *
	 * @param ind Either 'tab", 't", custom character or indentation level.
	 * @returns Indentation character sequence (character default: ` `).
	 */
	toIndent(ind: "tab" | "t" | string | number): string;
}

/**
 * @member bare Whether to add a top-level IIFE safety wrapper.
 * @member comments Whether to keep comments in the output.
 * @member compat Compatibility mode with JS.
 * @member filename File name for JS script to compile to CoffeeScript.
 * @member indent Indentation character(s) used in the compiler output.
 * @member source The source code itself - always overwritten by
 * `source` parameter.
 */
export interface IJS2CoffeeOptions {
	bare?: boolean;
	comments?: boolean;
	compat?: boolean;
	filename?: string;
	indent?: number;
	source?: string;
}

/**
 * Collection of syntax warnings to return to user (may be empty).
 */
export type IJS2CoffeeWarnings = IJS2CoffeeSyntaxProblem[] | [];

/**
 * Abstract syntax tree for CoffeeScript file.
 *
 * @member {CoffeeNode[]} body Collection of JS2Coffee nodes.
 */
export interface IJS2CoffeeAST extends Omit<Program, "body"> {
	body: CoffeeNode[];
}

/**
 * Abstract syntax tree for post-transform CoffeeScript.
 *
 * @member {IJS2CoffeeAST} ast Abstract syntax tree for CoffeeScript output.
 * @member {IJS2CoffeeWarnings} warnings Collection of syntax warnings.
 */
export interface IJS2CoffeeTransform {
	ast: IJS2CoffeeAST;
	warnings: IJS2CoffeeWarnings;
}

/**
 * Build output for JS code compiled to CoffeeScript.
 *
 * @member {IJS2CoffeeAST} ast Abstract syntax tree for CoffeeScript output.
 * @member {string} code Compiled CoffeeScript code.
 * @member {source-map#CodeWithSourceMap} map CoffeeScript code with source map
 * (see `source-map` NPM module typings for `CodeWithSourceMap`).
 * @member {IJS2CoffeeWarnings} warnings Collection of syntax warnings.
 */
export interface IJS2CoffeeBuild {
	ast: IJS2CoffeeAST;
	code: string;
	map: CodeWithSourceMap;
	warnings: IJS2CoffeeWarnings;
}

/**
 * Collection of helper functions used to parse JavaScript in JS2Coffee.
 *
 * @type {IJS2CoffeeHelpers}
 */
export let helpers: IJS2CoffeeHelpers;

/**
 * Compiles JavaScript into CoffeeScript.
 *
 * @param {string} source JavaScript code to compile. In order to compile JSON as CSON, you must wrap the string in
 * parentheses like so: `(...)`.
 * @param options {IJS2CoffeeOptions} JS2Coffee compiler options.
 * @param {boolean} [options.bare=false] Whether to add a top-level IIFE safety wrapper.
 * @param {boolean} [options.comments=true] Whether to keep comments in the output.
 * @param {boolean} [options.compat=false] Compatibility mode with JS.
 * @param {string} [options.filename=index.js] File name for JS script to compile to CoffeeScript.
 * @param {number} [options.indent=2] Indentation character(s) used in the compiler output.
 * @param {string} [options.source] The source code itself - always overwritten by
 * `source`.
 * @return {IJS2CoffeeBuild} Build output in CoffeeScript.
 */
export function build(source: string, options?: IJS2CoffeeOptions): IJS2CoffeeBuild;

/**
 * Compiles JavaScript into a ESTree-style CoffeeScript AST. The AST has the following custom types exclusive to
 * JS2Coffee:
 * - `CoffeeDoExpression`
 * - `CoffeeEscapedExpression`
 * - `CoffeeListExpression`
 * - `CoffeeLoopStatement`
 * - `CoffeePrototypeExpression`
 *
 * @param {string} source JavaScript code to compile. In order to compile JSON as CSON,
 * you must wrap the string in parentheses like so: `(...)`.
 * @param options {IJS2CoffeeOptions} JS2Coffee compiler options.
 * @param {boolean} [options.bare=false] Whether to add a top-level IIFE safety wrapper.
 * @param {boolean} [options.comments=true] Whether to keep comments in the output.
 * @param {boolean} [options.compat=false] Compatibility mode with JS.
 * @param {string} [options.filename=index.js] File name for JS script to compile to CoffeeScript.
 * @param {number} [options.indent=2] Indentation character(s) used in the compiler output.
 * @param {string} [options.source] The source code itself - always overwritten by
 * `source`.
 * @return {IJS2CoffeeBuild} Build output in CoffeeScript.
 */
export function parseJS(source: string, options?: IJS2CoffeeOptions): IJS2CoffeeAST;
export function transform(ast: Program, options?: IJS2CoffeeOptions): IJS2CoffeeTransform;
export function generate(ast: Program, options?: IJS2CoffeeOptions): CodeWithSourceMap;

/**
 * JS2Coffee API.
 *
 * @param {string} source JavaScript code to compile. In order to compile JSON as CSON, you must wrap the string in
 * parentheses like so: `(...)`.
 * @param options {IJS2CoffeeOptions} JS2Coffee compiler options.
 * @param {boolean} [options.bare=false] Whether to add a top-level IIFE safety wrapper.
 * @param {boolean} [options.comments=true] Whether to keep comments in the output.
 * @param {boolean} [options.compat=false] Compatibility mode with JS.
 * @param {string} [options.filename=index.js] File name for JS script to compile to CoffeeScript.
 * @param {number} [options.indent=2] Indentation character(s) used in the compiler output.
 * @param {string} [options.source] The source code itself - always overwritten by
 * `source`.
 * @return {IJS2CoffeeBuild} Build output in CoffeeScript.
 */
export default function(source: string, options?: IJS2CoffeeOptions): IJS2CoffeeBuild;

/**
 * Version number. Type defintions are written for JS2Coffee v1.9.2.
 *
 * @member {string}
 */
export let version: string;

export as namespace js2coffee;
