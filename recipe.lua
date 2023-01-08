Recipe = {
    ['beer'] = {
        ['recipe'] = {
            {name = 'bottle', require = 1, remove = true},
            {name = 'water', require = 1, remove = true},
            {name = 'wheat', require = 1, remove = true}
        },
        ['amount'] = 2,
        ['time'] = 20,
        ['allow'] = {'galaxy'}
    },
    ['mcdonalds_drink'] = {
        ['recipe'] = {
            {name = 'water', require = 1, remove = true},
            {name = 'sugar', require = 2, remove = true}
        },
        ['amount'] = 9,
        ['time'] = 2,
        ['allow'] = {'galaxy'}
    },
    ['bong'] = {
        ['recipe'] = {
            {name = 'plastic', require = 15, remove = true},
            {name = 'glass', require = 10, remove = true}
        },
        ['amount'] = 9,
        ['time'] = 2,
        ['allow'] = {'galaxy'}
    }
}


ReverseRecipe = {}


local function checkDup(t)
    local d = false
    for i = 1, #t, 1 do 
        local m = t[i]
        for _i = 1, #t, 1 do 
            if i ~= _i then 
                if m == t[_i] then 
                    d = true 
                end
            end
        end
    end
    return d
end
local function allstrings(n,t,k,s)
    k=k or 1
    s=s or {}
    if k>n then
        coroutine.yield(s)
    else
        for i=1,#t do
            s[k]=t[i]
            
            allstrings(n,t,k+1,s)
        end
    end
end

local function kmer(n,t)
    return coroutine.wrap(allstrings),n,t
end


for name, v in pairs(Recipe) do 
    local t = {}
    for i = 1, #v.recipe, 1 do 
        table.insert(t, v.recipe[i].name)
    end
    for w in kmer(#v.recipe, t) do 
        if not checkDup(w) then
            local index = table.concat(w)
            print(index)
            ReverseRecipe[index] = name
        end
    end
end
print(json.encode(ReverseRecipe))