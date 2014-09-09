program define sd 
    args home 

    if `"`home'"'=="" getdatadir
    else setdatadir `"`home'"'

    display as txt "Current datadir: " as result `"${datadir}"'

end

program define setdatadir 
    args home
    
    if `"${datadir}"'=="" {
        * begin with current directory
        local cdir : pwd
        * reverse for parsing
        local cdir = reverse(`"`cdir'"')
        local home = reverse(`"`home'"')
        * remove lowest directory level until reaching Data directory
        local folder ""
        while `"`folder'"'!=`"`home'"' & `"`cdir'"'!="" {
            gettoken folder : cdir , parse("\/")
            if `"`folder'"'!=`"`home'"' {
                gettoken folder cdir : cdir , parse("\/")
            }
        }
        * If specified directory was found, use what remains to specify data directory
        if `"`folder'"'==`"`home'"' {
            * Remove trailing /
            local cdir = reverse("`cdir'")
            display `"`cdir'"'
            global datadir `"`cdir'"' 
        }
        else {
            display as error "Directory not found in path of current working directory" 
            error 1
        }
    }
    * If datadir already defined 
    else display as result "datadir already defined: no change made"
end

program define getdatadir 

    if `"${datadir}"'=="" {
        display as error "datadir has not been defined" 
        error 1
    }

end


