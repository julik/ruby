class TestLastThread < Test::Unit::TestCase

  # [Bug #11237]
  def test_last_thread

    assert_separately([], <<-"end;") #do
      require '-test-/gvl/call_without_gvl'

      Thread.new {
        sleep 0.2
      }

      t0 = Time.now
      Thread.current.__runnable_sleep__ 1
      t1 = Time.now
      t = t1 - t0

      assert_operator(t, :>=, 1)
    end;
  end
end

