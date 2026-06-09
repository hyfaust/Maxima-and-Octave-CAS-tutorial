import katex from 'katex'

export default function katexPlugin(md) {
  const inlineRenderer = (tokens, idx) => {
    const token = tokens[idx]
    try {
      return katex.renderToString(token.content, {
        throwOnError: false,
        displayMode: false
      })
    } catch (e) {
      return `<span class="katex-error" title="${e.message}">${token.content}</span>`
    }
  }

  const blockRenderer = (tokens, idx) => {
    const token = tokens[idx]
    try {
      return `<div class="katex-block">${katex.renderToString(token.content, {
        throwOnError: false,
        displayMode: true
      })}</div>`
    } catch (e) {
      return `<div class="katex-block katex-error" title="${e.message}">${token.content}</div>`
    }
  }

  // Inline math: $...$
  md.inline.ruler.after('escape', 'math_inline', (state, silent) => {
    if (state.src[state.pos] !== '$') return false
    if (state.src[state.pos + 1] === '$') return false // Skip block math
    
    let start = state.pos + 1
    let end = start
    
    while (end < state.src.length && state.src[end] !== '$') {
      end++
    }
    
    if (end >= state.src.length) return false
    if (end === start) return false
    
    if (!silent) {
      const token = state.push('math_inline', 'math', 0)
      token.content = state.src.slice(start, end)
      token.markup = '$'
    }
    
    state.pos = end + 1
    return true
  })

  // Block math: $$...$$
  md.block.ruler.after('fence', 'math_block', (state, startLine, endLine, silent) => {
    let pos = state.bMarks[startLine] + state.tShift[startLine]
    let max = state.eMarks[startLine]
    
    if (state.src.slice(pos, pos + 2) !== '$$') return false
    if (state.src.slice(pos, pos + 4) === '$$$$') return false // Skip empty blocks
    
    pos += 2
    
    let firstLine = state.src.slice(pos, max).trim()
    let lastLine = ''
    let next = startLine + 1
    let found = false
    
    // Check if it's a single-line block
    if (firstLine.endsWith('$$')) {
      firstLine = firstLine.slice(0, -2).trim()
      found = true
    }
    
    // Find closing $$
    if (!found) {
      while (next < endLine) {
        pos = state.bMarks[next] + state.tShift[next]
        max = state.eMarks[next]
        
        let line = state.src.slice(pos, max).trim()
        
        if (line.endsWith('$$')) {
          lastLine = line.slice(0, -2).trim()
          found = true
          break
        }
        
        next++
      }
    }
    
    if (!found) return false
    if (silent) return true
    
    const token = state.push('math_block', 'math', 0)
    token.block = true
    token.content = firstLine
    if (lastLine) {
      token.content += '\n' + lastLine
    }
    token.markup = '$$'
    token.map = [startLine, next + 1]
    
    state.line = next + 1
    return true
  })

  md.renderer.rules.math_inline = inlineRenderer
  md.renderer.rules.math_block = blockRenderer
}