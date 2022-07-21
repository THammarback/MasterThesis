function g = gol_mat_main(f, w, width)
  [w_height, w_width] = size(w);
  f_amount = size(f,2)-((w_height-1)*width+w_width-1);
  g = zeros(f_amount, 1);

  for i = 1:f_amount
    for j = 1:w_height
      index = i+(j-1)*width;
      g(i) = g(i) + sum(f(index:index+w_width-1).*w(j,:)); 
    end
  end
end
