# frozen_string_literal: true

def sort_array(array)
  if array.length > 1 && !check_sort(array)
    result = shift_large_num(array) until check_sort(array)
    result
  else
    array
  end
end

def shift_large_num(array)
  array.each_index do |i|
    num1 = array[i]
    num2 = array[i + 1]
    if (i + 1 < array.length) && (num1 > num2)
      array[i] = num2
      array[i + 1] = num1
    end
  end
  array
end

def check_sort(array)
  jadge = true
  array.each_index do |i|
    num1 = array[i]
    num2 = array[i + 1]
    if (i + 1 < array.length) && (num1 > num2)
      jadge = false
      break
    end
  end
  jadge
end
