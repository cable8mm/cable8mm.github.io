---
layout: single
title: "Artisan::call(), 커맨드 상태에 주의하세요"
date: 2020-05-17 01:37:00
categories: development
tags: laravel
author: Samgu Lee
header:
  og_image: /assets/images/laravel-artisan.png
---

매일 점심 사먹을 돈이 최대 1만원까지 채워지는 마법의 지갑이 있다고 생각해봅시다. 오늘 점심을 먹기 위해 지출을 하면 내일 점심 때 다시 1만원이 되어 있는 지갑입니다.

![Laravel Artisan]({{ page.header.og_image }})

이를 커맨드로 만들어보면 간략히 다음과 같이 만들어볼 수 있을 겁니다.

```php
class LunchWalletCommand extends Command
{
    protected $signature = ‘payLunch’;

    private $dailyBudget = 10000;

    public function handle()
    {
        $this->pay();

        $this->recordRemainBudget();

        $this->info($this->dailyBudget();
    }

    private function pay()
    {
        $this->dailyBudget -= 8000;
    }

    private function recordRemainBudget()
    {
        RemainBudget::create([‘budget’ => $this->dailyBudget]);
    }
```

이 커맨드는 매일 오후 1시에 실행된다고 가정해봅시다.

```php
$schedule->command(‘payLunch’)->dailyAt(‘13:00’);
```

그러면 예상하시는대로 매일 일간 예산이 1만원으로 설정되고 8000원을 써서 2000원이 남게 됩니다. 남은 금액은 remain_budgets 테이블에 기록 되고요.

이를 테스트하기 위해 다음과 같은 아이디어를 낼 수 있습니다.

```php
/**
 * @test
 */
public function it_reset_everyday()
{
    Carbon::setTestNow(Carbon::yesterday());
    Artisan::call('command:test');

    Carbon::setTestNow(Carbon::now());
    Artisan::call('command:test');

    $this->assertEquals(2000, Artisan::output());
}
```

어제 날짜로 커맨드를 한 번 실행하고, 오늘 날짜로 다시 한 번 커맨드를 실행해보는 것이죠. 예상되는 결과는 2000이 출력되는 것 입니다. 커맨드 출력값을 확인하는 대신 remain_budgets 테이블에 기록되는 값을 확인하는 방법을 쓸 수도 있습니다.

하지만 이 테스트를 실행해보면 아래와 같이 실패합니다.

```sh
There was 1 failure:

1) Tests\Unit\ExampleTest::it_reset_everyday
Failed asserting that '-6000\n
' matches expected 2000.
```

2000이 출력 됐어야 했는데 -6000이 출력된 것이죠.

처음 실행한 커맨드의 상태가 남아있어서 두 번째 실행에서 $dailyBudget이 2000 - 8000이 되어 -6000이 된 것입니다. 두 번 실행한 커맨드가 독립적으로 실행되지 않고 하나의 인스턴스를 사용한 것으로 보입니다.

$this->artisan()을 사용해도 마찬가지 입니다.

```php
 /**
  * @test
  */
 public function it_reset_everyday()
 {
     Carbon::setTestNow(Carbon::yesterday());
     $this->artisan('payLunch')->expectsOutput(2000);

     Carbon::setTestNow(Carbon::now());
     $this->artisan('payLunch')->expectsOutput(2000);
 }
```

이 테스트 역시 통과하지 못합니다.

Artisan::call()로 같은 커맨드를 반복 실행할 때 이전 커맨드 실행의 상태가 남아있어 버그예상치 못한 결과가 발생할 수 있다는 점을 기억하세요.
