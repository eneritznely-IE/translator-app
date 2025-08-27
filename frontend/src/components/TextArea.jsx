// TextArea component
// A controlled textarea input that accepts a value, onChange handler, 
// placeholder, custom styles, and additional props.

export default function TextArea({value, onChange, placeholder, style, ...props}){
  return <textarea value={value} 
                   onChange={ (e) => onChange(e.target.value)} // update parent state on input
                   placeholder={placeholder} 
                   style={
                          {width:'100%',
                           minHeight:120,
                           padding:12,
                           fontSize:14,
                           resize: "vertical",
                           border: "1px solid #ccc",
                           borderRadius: 4,
                           outlineColor: "#2684ff",
                           ...style                     // allow overriding styles
                          }
                        }
                  {...props}                          // allow passing additional props like className, id, etc.
          />
}
