// Container component
// Wraps content in a centered, styled box with optional custom styles and props.

export default function Container({children, style, ...props}){
  return <div style={
                      {maxWidth:800, 
                       margin:'0 auto', 
                       background:'#fff', 
                       padding:24, 
                       borderRadius:8, 
                       ...style               // Merge with any custom styles passed via props
                      }
                    }
          {...props}                         // Allow additional props like className, id, etc.
          >
            {children}
          </div>
}
