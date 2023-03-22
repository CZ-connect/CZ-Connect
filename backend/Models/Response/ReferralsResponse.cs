namespace CZConnect.Models;

public class ReferralResponse
{
    public List<Referral> referrals { get; set; }
    public int completed { get; set; }
    public int pending { get; set; }
}
