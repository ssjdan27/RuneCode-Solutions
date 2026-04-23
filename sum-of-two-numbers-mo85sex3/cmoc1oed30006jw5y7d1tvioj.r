nums <- scan(file = "stdin", what = numeric(), quiet = TRUE)
cat(format(nums[1] + nums[2], scientific = FALSE, trim = TRUE), "\n", sep = "")